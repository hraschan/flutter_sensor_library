import '../../sensor_library.dart';
import '../time_series.dart';

abstract class Sensor extends TimeSeries {

  Sensor() {
    Library.checkIfOnWebProject();
  }

  getRaw();
  
}
