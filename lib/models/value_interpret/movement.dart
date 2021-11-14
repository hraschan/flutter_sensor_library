import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/return_types/movement_type.dart';
import 'package:sensor_library/models/return_types/sensor_vector_3.dart';
import 'package:sensor_library/models/sensors/sensor.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

class Movement extends SensorType {
  void setTransformValue(double relativeNull){}

  MovementType getMovementType() {
    return MovementType(fwd: true, left: false, right: false, bwd: false);
  }

  Future<bool> listenOnDirection(MovementType movementType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  SensorVector3 getMovementVector() {
    return SensorVector3(x: 10, y: 15, z: 2);
  }

  List<double> getVelocity(LengthUnit lengthUnit){
    List<double> velo = [];
    velo.add(22.5);
    velo.add(25.7);
    velo.add(30.2);
    return velo;
  }

  double getVelocityAtTimestamp(LengthUnit lengthUnit, DateTime timestamp) {
    return 22.5;
  }

  Future<bool> listenOnVelocity(double threshold) async{
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  List<double> getAcceleration(LengthUnit lengthUnit) {
    List<double> velo = [];
    velo.add(2.5);
    velo.add(5.7);
    velo.add(6.2);
    return velo;
  }

  double getAccelerationAtTimestamp(LengthUnit lengthUnit, DateTime timestamp) {
    return 2.5;
  }

  double getMaxAcceleration(LengthUnit lengthUnit) {
    return 6.2;
  }

  double getAvgAcceleration(LengthUnit lengthUnit) {
    return 4.0;
  }

  double getMinAcceleration(LengthUnit lengthUnit) {
    return 2.5;
  }
}