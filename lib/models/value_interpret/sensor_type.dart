import 'package:sensor_library/models/return_types/sensor_vector_3.dart';
import 'package:sensor_library/models/time_series.dart';

abstract class SensorType {
  TimeSeries timeSeries = TimeSeries();
}