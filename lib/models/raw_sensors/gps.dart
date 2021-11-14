import 'package:sensor_library/models/sensors/sensor.dart';

class Gps extends Sensor {

  // type not specified as the library 
  // provides more raw data than covered by one method
  @override
  getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}