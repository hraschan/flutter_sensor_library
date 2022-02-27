import 'package:sensor_library/models/raw_sensors/sensor.dart';

import '../../sensor_library.dart';

class Proximity extends Sensor {

  Proximity() {
    Library.checkIfOnWebProject();
    throw UnimplementedError("Proximity sensor not available.");
  }

  @override
  int getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError("Proximity sensor not available.");
  }
  
}