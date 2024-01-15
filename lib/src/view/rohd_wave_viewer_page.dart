import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rohd_wave_viewer/src/ui/shared/appbar/waveform_menubar.dart';
import 'package:rohd_wave_viewer/src/view/waveform_body.dart';

class RohdWaveViewer extends StatelessWidget {
  const RohdWaveViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink.shade50,
        child: const Column(
          children: [
            WaveformMenubar(),
            WaveformBody(),
          ],
        ),
      ),
    );
  }
}
