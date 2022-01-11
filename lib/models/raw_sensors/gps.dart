
import 'package:sensor_library/models/raw_sensors/sensor.dart';

import '../../sensor_library.dart';

class Gps extends Sensor {

  Gps() {
    Library.checkIfOnWebProject();
  }

  // type not specified as the library 
  // provides more raw data than covered by one method
  @override
  getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}