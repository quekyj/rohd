import 'dart:convert';

import 'package:rohd_wave_viewer/src/models/waveform_model.dart';

WaveformModel generateWaveFormNode() {
  // This is the JSON string that you want to parse.
  String jsonString = '''
  {
    "metadata": {
      "source": "Source1",
      "timescale": "1ns",
      "date": "2022-01-01"
    },
    "modules": [
      {
        "name": "Counter",
        "subModules": [
          {
            "name": "counter_sub_module",
            "subModules": [],
            "signals": [
              {
                "name": "SubSignal1",
                "type": "SubType1",
                "data": [
                  {
                    "time": 3,
                    "value": 300
                  },
                  {
                    "time": 4,
                    "value": 400
                  }
                ]
              }
            ]
          }
        ],
        "signals": [
          {
            "name": "Signal1",
            "type": "Type1",
            "data": [
              {
                "time": 1,
                "value": 100
              },
              {
                "time": 2,
                "value": 200
              }
            ]
          },
          {
            "name": "Signal2",
            "type": "Type2",
            "data": [
              {
                "time": 5,
                "value": 500
              },
              {
                "time": 6,
                "value": 600
              }
            ]
          }
        ]
      }
    ]
  }
  ''';

  // Parse the JSON string into a Map.
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Use the fromJson factory constructor to create a WaveformNode object.
  return WaveformModel.fromJson(jsonMap);
}
