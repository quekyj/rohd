import 'package:flutter/material.dart';

class SignalTabContainer extends StatelessWidget {
  final Widget containerBody;
  const SignalTabContainer({super.key, required this.containerBody});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        width: double.infinity,
        child: containerBody,
      ),
    );
  }
}
