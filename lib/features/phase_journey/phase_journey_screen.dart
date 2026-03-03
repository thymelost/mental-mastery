import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import 'phase_journey_provider.dart';
import 'widgets/phase_node.dart';

class PhaseJourneyScreen extends ConsumerWidget {
  const PhaseJourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(phaseJourneyProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Your Journey'),
          floating: true,
          snap: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              '9 phases · Foundation → Metacognition → Intentional Plasticity',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: spaceSm),
          sliver: SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => PhaseNode(
              item: items[index],
              isLast: index == items.length - 1,
            ),
          ),
        ),
        // Bottom padding for nav bar
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }
}
