import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tokens.dart';
import '../progress_provider.dart';

/// Metrics tab: shows a dropdown of available metrics and a line chart
/// for the selected metric over time.
class MetricChartsTab extends ConsumerStatefulWidget {
  const MetricChartsTab({super.key});

  @override
  ConsumerState<MetricChartsTab> createState() => _MetricChartsTabState();
}

class _MetricChartsTabState extends ConsumerState<MetricChartsTab> {
  String? _selectedMetricId;

  @override
  Widget build(BuildContext context) {
    final allIdsAsync = ref.watch(allMetricIdsProvider);
    final theme = Theme.of(context);

    return allIdsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (ids) {
        if (ids.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.show_chart, size: 48, color: onSurfaceMuted),
                const SizedBox(height: spaceMd),
                Text(
                  'No metric data yet.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: spaceXs),
                Text(
                  'Metrics are recorded automatically when you complete assessments.',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: onSurfaceMuted),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Auto-select first metric if none chosen.
        _selectedMetricId ??= ids.first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Metric selector ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(spaceMd, spaceMd, spaceMd, 0),
              child: DropdownButtonFormField<String>(
                value: _selectedMetricId,
                decoration: const InputDecoration(
                  labelText: 'Metric',
                  isDense: true,
                ),
                items: ids
                    .map((id) => DropdownMenuItem(
                          value: id,
                          child: Text(
                            id,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMetricId = v),
              ),
            ),

            // ── Chart ─────────────────────────────────────────────────
            Expanded(
              child: _selectedMetricId == null
                  ? const SizedBox.shrink()
                  : _MetricChart(metricId: _selectedMetricId!),
            ),
          ],
        );
      },
    );
  }
}

class _MetricChart extends ConsumerWidget {
  const _MetricChart({required this.metricId});
  final String metricId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(longitudinalMetricProvider(metricId));
    final theme = Theme.of(context);

    return dataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (snapshots) {
        if (snapshots.isEmpty) {
          return Center(
            child: Text(
              'No data for $metricId yet.',
              style: theme.textTheme.bodySmall?.copyWith(color: onSurfaceMuted),
            ),
          );
        }

        final spots = snapshots.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.value);
        }).toList();

        final minY = snapshots.map((s) => s.value).reduce(
              (a, b) => a < b ? a : b,
            );
        final maxY = snapshots.map((s) => s.value).reduce(
              (a, b) => a > b ? a : b,
            );
        final padding = (maxY - minY) * 0.15;

        return Padding(
          padding: const EdgeInsets.fromLTRB(spaceMd, spaceLg, spaceLg, spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metricId,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: primaryTeal,
                  letterSpacing: 1.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              const SizedBox(height: spaceMd),
              Expanded(
                child: LineChart(
                  LineChartData(
                    minY: (minY - padding).clamp(0, double.infinity),
                    maxY: maxY + padding,
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: onSurfaceMuted.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (_) => FlLine(
                        color: onSurfaceMuted.withValues(alpha: 0.05),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                            color: onSurfaceMuted.withValues(alpha: 0.2)),
                        left: BorderSide(
                            color: onSurfaceMuted.withValues(alpha: 0.2)),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (val, meta) {
                            final idx = val.toInt();
                            if (idx < 0 || idx >= snapshots.length) {
                              return const SizedBox.shrink();
                            }
                            if (idx % _labelStep(snapshots.length) != 0) {
                              return const SizedBox.shrink();
                            }
                            final dt = snapshots[idx].recordedAt;
                            return Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${dt.month}/${dt.day}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                  color: onSurfaceMuted,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (val, _) => Text(
                            val.toStringAsFixed(0),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                              color: onSurfaceMuted,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.25,
                        color: primaryTeal,
                        barWidth: 2,
                        dotData: FlDotData(
                          getDotPainter: (_, __, ___, ____) =>
                              FlDotCirclePainter(
                            radius: 3,
                            color: primaryTeal,
                            strokeWidth: 1,
                            strokeColor: backgroundDark,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: primaryTeal.withValues(alpha: 0.06),
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (spots) => spots.map((s) {
                          final idx = s.x.toInt();
                          final snapshot = snapshots[idx];
                          return LineTooltipItem(
                            '${snapshot.value.toStringAsFixed(1)}\n'
                            'Phase ${snapshot.phaseNumber}',
                            theme.textTheme.labelSmall?.copyWith(
                                  color: onSurfaceDark,
                                ) ??
                                const TextStyle(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: spaceXs),
              Text(
                '${snapshots.length} data points',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: onSurfaceMuted),
              ),
            ],
          ),
        );
      },
    );
  }

  int _labelStep(int count) {
    if (count <= 10) return 1;
    if (count <= 30) return 5;
    return 10;
  }
}
