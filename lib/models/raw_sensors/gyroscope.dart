import '../../sensor_library.dart';
import 'sensor.dart';
import '../return_types/sensor_vector_3.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Gyroscope extends Sensor {

  int inMillis;

  Gyroscope({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<SensorVector3> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return mapCustomEventsToSensorVector<GyroscopeEvent>(gyroscopeEvents).where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis){
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<SensorVector3> getRawWithoutTimeLimit() {
    return mapCustomEventsToSensorVector<GyroscopeEvent>(gyroscopeEvents);
  }
  
}