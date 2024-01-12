import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/ui/shared/appbar/waveform_appbar.dart';
import 'package:rohd_wave_viewer/src/view/waveform_body.dart';

class RohdWaveViewer extends StatelessWidget {
  const RohdWaveViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          WaveformAppbar(),
          WaveformBody(),
        ],
      ),
    );
  }
}
