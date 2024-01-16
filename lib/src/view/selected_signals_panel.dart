import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/ui/tree_card.dart';

class SelectedSignalsPanel extends StatelessWidget {
  const SelectedSignalsPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TreeCard(
        cardTitle: 'Selected Signals',
        cardBody: Text('User Selected Signals stay here.'));
  }
}
