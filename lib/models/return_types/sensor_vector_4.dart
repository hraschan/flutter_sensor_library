import 'package:sensor_library/models/return_types/sensor_vector_3.dart';

class SensorVector4 extends SensorVector3{
  double time;

  SensorVector4({required double x, required double y, required double z, required this.time}) : super(x: x, y: y, z: z);
}