import 'package:sensor_library/models/return_types/movement_type.dart';

class MovementValue{
  double value;
  MovementType direction;

  MovementValue({required this.value, required this.direction});
}