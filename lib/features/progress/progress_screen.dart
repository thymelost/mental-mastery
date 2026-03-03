import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';
import 'widgets/metric_charts_tab.dart';
import 'widgets/phase_timeline_tab.dart';

/// Progress screen: two tabs — phase journey timeline and longitudinal
/// metric charts.
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.account_tree_outlined), text: 'Journey'),
            Tab(icon: Icon(Icons.show_chart), text: 'Metrics'),
          ],
          labelColor: primaryTeal,
          indicatorColor: primaryTeal,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PhaseTimelineTab(),
          MetricChartsTab(),
        ],
      ),
    );
  }
}
