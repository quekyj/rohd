import 'package:flutter/material.dart';

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
