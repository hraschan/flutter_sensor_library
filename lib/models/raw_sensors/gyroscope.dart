import '../../sensor_library.dart';
import 'sensor.dart';
import '../return_types/sensor_vector_3.dart';

class Gyroscope extends Sensor {

  Gyroscope() {
    Library.checkIfOnWebProject();
  }

  @override
  SensorVector3 getRaw() {
    // TODO: implement getRaw
    throw UnimplementedError();
  }
  
}