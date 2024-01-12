import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/view/rohd_wave_viewer_page.dart';

void main() {
  runApp(const WaveformTracer());
}

class WaveformTracer extends StatelessWidget {
  const WaveformTracer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROHD Waveform Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RohdWaveViewer(),
    );
  }
}
