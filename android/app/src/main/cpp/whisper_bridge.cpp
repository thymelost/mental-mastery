// whisper_bridge.cpp — thin C bridge between whisper.cpp and Dart FFI.
//
// Exported functions:
//   whisper_bridge_init_from_file(model_path)        → void* ctx (nullptr on error)
//   whisper_bridge_transcribe_file(ctx, wav_path)    → const char* (heap; caller must free)
//   whisper_bridge_free_string(s)                    → void
//   whisper_bridge_free(ctx)                         → void
//
// WAV parsing: inline RIFF/WAVE reader — no dr_wav dependency.
// Audio: mono or stereo int16 → float32 at 16 kHz.
// Params: WHISPER_SAMPLING_GREEDY, n_threads=4, language="en", no translation.

#include "whisper.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

// ── Compiler export macro ──────────────────────────────────────────────────

#ifdef __cplusplus
#define WHISPER_BRIDGE_EXPORT extern "C" __attribute__((visibility("default")))
#else
#define WHISPER_BRIDGE_EXPORT __attribute__((visibility("default")))
#endif

// ── Inline WAV reader ──────────────────────────────────────────────────────
//
// Reads a RIFF/WAVE file containing PCM int16 samples.
// Handles mono and stereo (stereo is averaged down to mono).
// Returns false on any parse error.

static bool read_wav(const char* path,
                     std::vector<float>& out_samples,
                     uint32_t& out_sample_rate,
                     uint16_t& out_channels) {
    FILE* f = fopen(path, "rb");
    if (!f) return false;

    // Helper: read exactly n bytes
    auto read_bytes = [&](void* buf, size_t n) -> bool {
        return fread(buf, 1, n, f) == n;
    };
    auto read_u32 = [&](uint32_t& v) -> bool { return read_bytes(&v, 4); };
    auto read_u16 = [&](uint16_t& v) -> bool { return read_bytes(&v, 2); };

    // RIFF chunk
    char riff_id[4];
    uint32_t riff_size;
    char wave_id[4];
    if (!read_bytes(riff_id, 4) || !read_u32(riff_size) || !read_bytes(wave_id, 4)) {
        fclose(f); return false;
    }
    if (memcmp(riff_id, "RIFF", 4) != 0 || memcmp(wave_id, "WAVE", 4) != 0) {
        fclose(f); return false;
    }

    uint16_t audio_format = 0, num_channels = 0, bits_per_sample = 0;
    uint32_t sample_rate = 0, data_size = 0;
    bool found_fmt = false, found_data = false;

    // Walk sub-chunks until we have fmt + data
    while (!found_data) {
        char chunk_id[4];
        uint32_t chunk_size;
        if (!read_bytes(chunk_id, 4) || !read_u32(chunk_size)) {
            fclose(f); return false;
        }

        if (memcmp(chunk_id, "fmt ", 4) == 0) {
            if (!read_u16(audio_format) ||
                !read_u16(num_channels) ||
                !read_u32(sample_rate) ) {
                fclose(f); return false;
            }
            // skip byte_rate (4) + block_align (2)
            uint32_t byte_rate; uint16_t block_align;
            if (!read_u32(byte_rate) || !read_u16(block_align)) { fclose(f); return false; }
            if (!read_u16(bits_per_sample)) { fclose(f); return false; }
            // skip any extra fmt bytes
            if (chunk_size > 16) fseek(f, (long)(chunk_size - 16), SEEK_CUR);
            found_fmt = true;

        } else if (memcmp(chunk_id, "data", 4) == 0) {
            if (!found_fmt) { fclose(f); return false; }
            if (audio_format != 1 || bits_per_sample != 16) {
                // Only PCM 16-bit supported
                fclose(f); return false;
            }
            data_size = chunk_size;
            uint32_t num_samples_total = data_size / sizeof(int16_t);
            std::vector<int16_t> raw(num_samples_total);
            if (fread(raw.data(), sizeof(int16_t), num_samples_total, f)
                    != num_samples_total) {
                fclose(f); return false;
            }

            uint32_t num_frames = num_samples_total / num_channels;
            out_samples.resize(num_frames);
            if (num_channels == 1) {
                for (uint32_t i = 0; i < num_frames; ++i) {
                    out_samples[i] = raw[i] / 32768.0f;
                }
            } else {
                // Average all channels to mono
                for (uint32_t i = 0; i < num_frames; ++i) {
                    float sum = 0.0f;
                    for (uint16_t c = 0; c < num_channels; ++c) {
                        sum += raw[i * num_channels + c] / 32768.0f;
                    }
                    out_samples[i] = sum / num_channels;
                }
            }

            out_sample_rate = sample_rate;
            out_channels    = num_channels;
            found_data = true;

        } else {
            // Skip unknown chunk (pad to even)
            uint32_t skip = chunk_size + (chunk_size & 1);
            fseek(f, (long)skip, SEEK_CUR);
        }
    }

    fclose(f);
    return found_data;
}

// ── Exported bridge functions ──────────────────────────────────────────────

WHISPER_BRIDGE_EXPORT
void* whisper_bridge_init_from_file(const char* model_path) {
    if (!model_path) return nullptr;
    whisper_context_params cparams = whisper_context_default_params();
    cparams.use_gpu = false;
    whisper_context* ctx = whisper_init_from_file_with_params(model_path, cparams);
    return static_cast<void*>(ctx);
}

WHISPER_BRIDGE_EXPORT
const char* whisper_bridge_transcribe_file(void* ctx_ptr, const char* wav_path) {
    if (!ctx_ptr || !wav_path) return nullptr;
    auto* ctx = static_cast<whisper_context*>(ctx_ptr);

    std::vector<float> samples;
    uint32_t sample_rate = 0;
    uint16_t channels    = 0;
    if (!read_wav(wav_path, samples, sample_rate, channels)) return nullptr;
    if (samples.empty()) return nullptr;

    whisper_full_params params = whisper_full_default_params(WHISPER_SAMPLING_GREEDY);
    params.n_threads        = 4;
    params.language         = "en";
    params.translate        = false;
    params.print_special    = false;
    params.print_progress   = false;
    params.print_realtime   = false;
    params.print_timestamps = false;

    if (whisper_full(ctx, params, samples.data(), (int)samples.size()) != 0) {
        return nullptr;
    }

    int n_segments = whisper_full_n_segments(ctx);
    std::string result;
    for (int i = 0; i < n_segments; ++i) {
        const char* seg = whisper_full_get_segment_text(ctx, i);
        if (!seg) continue;
        // Skip leading whitespace on each segment before appending
        const char* trimmed = seg;
        while (*trimmed == ' ') ++trimmed;
        if (*trimmed == '\0') continue;
        if (!result.empty()) result += ' ';
        result += trimmed;
    }

    char* out = new char[result.size() + 1];
    memcpy(out, result.c_str(), result.size() + 1);
    return out;
}

WHISPER_BRIDGE_EXPORT
void whisper_bridge_free_string(const char* s) {
    delete[] s;
}

WHISPER_BRIDGE_EXPORT
void whisper_bridge_free(void* ctx_ptr) {
    if (ctx_ptr) {
        whisper_free(static_cast<whisper_context*>(ctx_ptr));
    }
}
