import 'package:flutter_barometer_plugin/flutter_barometer.dart';

import '../../sensor_library.dart';
import 'sensor.dart';

class Barometer extends Sensor {
  
  int inMillis;

  Barometer({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<BarometerValue> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return FlutterBarometer.currentPressureEvent.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<BarometerValue> getRawWithoutTimelimit() {
    return FlutterBarometer.currentPressureEvent;
  }
}
