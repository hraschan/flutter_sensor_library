
import 'package:sensor_library/models/raw_sensors/sensor.dart';

class Gps extends Sensor {

  // type not specified as the library 
  // provides more raw data than covered by one method
  @override
  getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}