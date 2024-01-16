import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/constants/colors.dart';

class TreeCard extends StatelessWidget {
  final Widget cardBody;
  final String cardTitle;
  final List<Widget>? headerAction;

  const TreeCard({
    super.key,
    required this.cardTitle,
    required this.cardBody,
    this.headerAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tertiaryColor,
      child: Column(
        children: <Widget>[
          AreaPaneHeader(
            title: Text(cardTitle),
            actions: headerAction ?? [],
          ),
          cardBody,
        ],
      ),
    );
  }
}
