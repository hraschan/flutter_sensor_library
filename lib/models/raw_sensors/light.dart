import 'package:sensor_library/models/raw_sensors/sensor.dart';

import '../../sensor_library.dart';

class Light extends Sensor {

  Light() {
    Library.checkIfOnWebProject();
  }

  @override
  int getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}