import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/constants/colors.dart';
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
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: primaryColor),
          headlineMedium: TextStyle(color: primaryColor),
          headlineSmall: TextStyle(color: primaryColor),
          displayLarge: TextStyle(color: primaryColor),
          displayMedium: TextStyle(color: primaryColor),
          displaySmall: TextStyle(color: primaryColor),
          titleLarge: TextStyle(color: primaryColor),
          titleMedium: TextStyle(color: primaryColor),
          titleSmall: TextStyle(color: primaryColor),
          bodyLarge: TextStyle(color: primaryColor),
          bodyMedium: TextStyle(color: primaryColor),
          bodySmall: TextStyle(color: primaryColor),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
        menuTheme: const MenuThemeData(
          style: MenuStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 5),
            ),
          ),
        ),
        useMaterial3: true,
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
      ),
      home: const RohdWaveViewer(),
    );
  }
}
