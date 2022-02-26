import 'package:light/light.dart';
import 'package:sensor_library/models/raw_sensors/sensor.dart';

import '../../sensor_library.dart';

class LightSensor extends Sensor {
  int inMillis;
  final Light _light = Light();

  LightSensor({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<int> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return _light.lightSensorStream.where((element) {
      if(DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<int> getRawWithoutTimeLimit() {
    return _light.lightSensorStream;
  }
  
}