package com.mentalmastery.mental_mastery

import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Platform channel plugin that exposes Android build information needed to
 * decide whether on-device GenAI speech recognition is likely available.
 *
 * Channel: com.mentalmastery/genai_capability
 *
 * Methods:
 *   isGenAiSpeechAvailable → Boolean
 *     Returns true if Android SDK >= 34 (Android 14, "Upside Down Cake").
 *     Android 14+ is required for on-device Gemini Nano / ML Kit GenAI features.
 *     This is a necessary-but-not-sufficient check; hardware support (Pixel 8+
 *     or equivalent) is not verifiable from pure build info. The Flutter-side
 *     MlKitGenAiEngine.isAvailable() performs the definitive check by
 *     attempting to initialise the recogniser.
 *
 *   getSdkInt → Int
 *     Returns Build.VERSION.SDK_INT for diagnostic use.
 */
class GenAiCapabilityPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    companion object {
        const val CHANNEL = "com.mentalmastery/genai_capability"
        // Android 14 (API 34) is the first version to ship Gemini Nano on Pixel.
        const val MIN_GENAI_SDK = 34
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "isGenAiSpeechAvailable" ->
                result.success(Build.VERSION.SDK_INT >= MIN_GENAI_SDK)

            "getSdkInt" ->
                result.success(Build.VERSION.SDK_INT)

            else -> result.notImplemented()
        }
    }
}
