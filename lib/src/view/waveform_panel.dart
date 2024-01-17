import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rohd_wave_viewer/src/providers/selected_signals_list_provider.dart';
import 'package:rohd_wave_viewer/src/services/waveform_signals.dart';
import 'package:rohd_wave_viewer/src/ui/module_signal_card.dart';
import 'package:rohd_wave_viewer/src/ui/signal_tab_container.dart';
import 'package:rohd_wave_viewer/src/ui/waveform_painter.dart';

class WaveformPanel extends ConsumerStatefulWidget {
  const WaveformPanel({super.key});

  @override
  ConsumerState<WaveformPanel> createState() => _WaveformPanelState();
}

class _WaveformPanelState extends ConsumerState<WaveformPanel> {
  @override
  Widget build(BuildContext context) {
    final signals = ref.watch(selectedSignalsListProvider);
    final waveformSignals = signals
        .map(
          (signal) => drawWaveform(WaveformSignals.getSignalData(signal)),
        )
        .toList();

    // Read the waveform data from the provider
    return ModuleSignalCard(
      cardTitle: 'Simulation',
      cardBody: Column(
        children: waveformSignals,
      ),
    );
  }

  SignalTabContainer drawWaveform(List<int> data) {
    return SignalTabContainer(
      containerBody: CustomPaint(
        size: const Size(20, 20), // Arbitrary size
        painter: WaveformPainter(data),
      ),
    );
  }
}
