import 'package:sensor_library/models/raw_sensors/sensor.dart';

import '../../sensor_library.dart';

class Proximity extends Sensor {

  Proximity() {
    Library.checkIfOnWebProject();
  }

  @override
  int getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}