import 'package:flutter/material.dart';

class WaveformMenubar extends StatelessWidget {
  const WaveformMenubar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Text('File'),
              Text('View'),
              Text('Settings'),
              Text('Help'),
            ],
          ),
        ),
        Container(
          color: Colors.indigo,
          child: const Row(
            children: [
              Text('Open File'),
              Text('Download File'),
              Text('Others control action'),
            ],
          ),
        )
      ],
    );
  }
}
