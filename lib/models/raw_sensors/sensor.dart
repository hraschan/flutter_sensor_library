import '../time_series.dart';

abstract class Sensor extends TimeSeries {
  getRaw();
  
}
