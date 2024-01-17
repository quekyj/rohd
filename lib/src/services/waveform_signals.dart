import 'package:rohd_wave_viewer/src/models/waveform_model.dart';

class WaveformSignals {
  static List<int> getSignalData(Signal signal) {
    return signal.data.map((data) => data.value).toList();
  }

  static List<int> getSignalTime(Signal signal) {
    return signal.data.map((data) => data.time).toList();
  }
}
