import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/constants/colors.dart';
import 'package:rohd_wave_viewer/src/view/module_signal_list_panel.dart';
import 'package:rohd_wave_viewer/src/view/selected_signals_panel.dart';
import 'package:rohd_wave_viewer/src/view/waveform_panel.dart';

class WaveformBody extends StatefulWidget {
  const WaveformBody({super.key});

  @override
  State<WaveformBody> createState() => _WaveformBodyState();
}

class _WaveformBodyState extends State<WaveformBody> {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - 80;

    return Expanded(
      child: Split(
        axis: Axis.horizontal,
        initialFractions: const [0.2, 0.2, 0.6],
        minSizes: const [200, 200, 600],
        children: [
          Container(
            height: bodyHeight,
            color: primaryColor,
            child: const ModuleSignalsListPanel(),
          ),
          Container(
            height: bodyHeight,
            child: SelectedSignalsPanel(),
          ),
          Container(
            height: bodyHeight,
            child: WaveformPanel(),
          ),
        ],
      ),
    );
  }
}
