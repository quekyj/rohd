import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WaveformBody extends StatefulWidget {
  const WaveformBody({super.key});

  @override
  State<WaveformBody> createState() => _WaveformBodyState();
}

class _WaveformBodyState extends State<WaveformBody> {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - 80;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: bodyHeight,
            color: Colors.deepOrangeAccent,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: Center(child: Text('Available Modules')),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Color.fromARGB(255, 172, 75, 96),
                    child:
                        Center(child: Text('Signals that reside in a module')),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: bodyHeight,
            color: Colors.grey,
            child: Center(child: Text('User selected signals stay here')),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: bodyHeight,
            color: Colors.greenAccent,
            child: Center(child: Text('Waveform UI stay here')),
          ),
        ),
      ],
    );
  }
}
