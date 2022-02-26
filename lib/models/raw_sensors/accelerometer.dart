import 'package:sensor_library/models/return_types/sensor_vector_3.dart';
import 'package:sensor_library/models/raw_sensors/sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../sensor_library.dart';

class Accelerometer extends Sensor {
  int inMillis;
  
  Accelerometer({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<SensorVector3> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return mapCustomEventsToSensorVector<UserAccelerometerEvent>(userAccelerometerEvents).where((element) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall >
          inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<SensorVector3> getRawWithoutTimeLimit() {
    return mapCustomEventsToSensorVector<UserAccelerometerEvent>(userAccelerometerEvents);
  }

  Stream<SensorVector3> getRawWithGravity() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return mapCustomEventsToSensorVector<AccelerometerEvent>(accelerometerEvents).where((element) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall >
          inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }
}
