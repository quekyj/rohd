import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rohd_wave_viewer/src/providers/selected_signals_list_provider.dart';
import 'package:rohd_wave_viewer/src/ui/module_signal_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rohd_wave_viewer/src/ui/signal_tab_container.dart';

class SelectedSignalsPanel extends ConsumerStatefulWidget {
  const SelectedSignalsPanel({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectedSignalsPanelState();
}

class _SelectedSignalsPanelState extends ConsumerState<SelectedSignalsPanel> {
  @override
  Widget build(BuildContext context) {
    return ModuleSignalCard(
      cardTitle: 'Selected Signals',
      cardBody: Expanded(
        child: Column(
          children: _populateSelectedSignals(),
        ),
      ),
    );
  }

  List<Widget> _populateSelectedSignals() {
    if (ref.watch(selectedSignalsListProvider).isNotEmpty) {
      return ref
          .watch(selectedSignalsListProvider)
          .map(
            (signal) => SignalTabContainer(
              containerBody: Text(
                signal.name,
                textAlign: TextAlign.right,
              ),
            ),
          )
          .toList();
    }

    return [];
  }
}
