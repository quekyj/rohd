import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rohd_wave_viewer/src/constants/colors.dart';
import 'package:rohd_wave_viewer/src/view/rohd_wave_viewer_page.dart';
import 'package:devtools_app_shared/utils.dart';

void main() {
  setGlobal(IdeTheme, getIdeTheme());
  runApp(
    const ProviderScope(
      child: WaveformTracer(),
    ),
  );
}

class WaveformTracer extends StatelessWidget {
  const WaveformTracer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROHD Waveform Viewer',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: textColor),
          headlineMedium: TextStyle(color: textColor),
          headlineSmall: TextStyle(color: textColor),
          displayLarge: TextStyle(color: textColor),
          displayMedium: TextStyle(color: textColor),
          displaySmall: TextStyle(color: textColor),
          titleLarge: TextStyle(color: textColor),
          titleMedium: TextStyle(color: textColor),
          titleSmall: TextStyle(color: textColor),
          bodyLarge: TextStyle(color: textColor),
          bodyMedium: TextStyle(color: textColor),
          bodySmall: TextStyle(color: textColor),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: textColor),
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
