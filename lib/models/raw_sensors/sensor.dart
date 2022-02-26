import 'package:sensor_library/models/return_types/sensor_vector_3.dart';

import '../../sensor_library.dart';
import '../time_series.dart';

abstract class Sensor extends TimeSeries {

  Sensor() {
    Library.checkIfOnWebProject();
  }

  getRaw();

  Stream<SensorVector3> mapCustomEventsToSensorVector<T>(Stream<T> eventStream){
    return eventStream
      .asyncMap((dynamic event) => SensorVector3(x: event.x, y: event.y, z: event.z));
  }
}
