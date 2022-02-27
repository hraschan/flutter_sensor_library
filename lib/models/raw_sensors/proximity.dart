import 'package:sensor_library/models/raw_sensors/sensor.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

import '../../sensor_library.dart';

class Proximity extends Sensor {

  int inMillis;

  Proximity({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<int> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return ProximitySensor.events.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<int> getRawWithoutTimelimit() {
    return ProximitySensor.events;
  }
  
}