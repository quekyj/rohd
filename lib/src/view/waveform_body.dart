import 'package:flutter/material.dart';

class WaveformBody extends StatefulWidget {
  const WaveformBody({super.key});

  @override
  State<WaveformBody> createState() => _WaveformBodyState();
}

class _WaveformBodyState extends State<WaveformBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
                child: Text('ROHD Modules'),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red.shade300,
                child: Text('ROHD Signals'),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.amber,
          child: Text('Selected Signals'),
        ),
        Container(
          color: Colors.blueAccent,
          child: Text('Show Waveform here! Provide interaction!'),
        ),
      ],
    );
  }
}
