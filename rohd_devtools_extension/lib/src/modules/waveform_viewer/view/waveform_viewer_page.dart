import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

// A provider to generate random binary waveform data
final waveformProvider = Provider<List<int>>((ref) {
  Random rng = new Random();
  return List<int>.generate(40, (i) => rng.nextInt(2));
});

class WaveformView extends ConsumerWidget {
  const WaveformView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the waveform data from the provider
    final waveform = ref.watch(waveformProvider);

    return Container(
      child: Center(
        child: CustomPaint(
          size: Size(double.infinity, 200), // Arbitrary size
          painter: WaveformPainter(waveform),
        ),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<int> waveform;

  WaveformPainter(this.waveform);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Create a digital waveform path
    for (int i = 0; i < waveform.length; i++) {
      final x = size.width / waveform.length * i;
      final y = size.height * (1 - waveform[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      path.lineTo(x + size.width / waveform.length, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
