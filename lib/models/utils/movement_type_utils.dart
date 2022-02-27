import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:sensor_library/models/return_types/movement_type.dart';
import 'package:sensor_library/models/return_types/movement_value.dart';
import 'package:sensor_library/models/return_types/sensor_vector_3.dart';
import 'package:sensor_library/models/return_types/sensor_vector_4.dart';

class MovementTypeUtils {

  static Stream<MovementType> mapSensorVectorToMovementType(Stream<SensorVector3> stream) {
    return stream
        .asyncMap((event) {
          if(_isFwdMovement(event)){
            print("fwd");
            return MovementType(fwd: true, left: false, right: false, bwd: false, up: false, down: false);
          } else if(_isBwdMovement(event)){
            print("bwd");
            return MovementType(fwd: false, left: false, right: false, bwd: true, up: false, down: false);
          } else if(_isLeftMovement(event)){
            print("lwd");
            return MovementType(fwd: false, left: true, right: false, bwd: false, up: false, down: false);
          } else if(_isRightMovement(event)){
            print("rwd");
            return MovementType(fwd: false, left: false, right: true, bwd: false, up: false, down: false);
          } else if(_isUpMovement(event)){
            print("up");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: true, down: false);
          } else if(_isDownMovement(event)){ 
            print("down");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: true);
          } else {
            print("no movement");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: false);
          }
        });
  }

  static bool _isFwdMovement(SensorVector3 vector){
    return vector.y > 1 && _dirMmntBiggerThanOther(vector);
  }

  static bool _isBwdMovement(SensorVector3 vector){
    return vector.y < -1 && _dirMmntBiggerThanOther(vector);
  }

  static bool _isLeftMovement(SensorVector3 vector){
    return vector.x < -1 && _sideMmntBiggerThanOther(vector);
  }

  static bool _isRightMovement(SensorVector3 vector){
    return vector.x > 1 && _sideMmntBiggerThanOther(vector);
  }

  static bool _isUpMovement(SensorVector3 vector){
    return vector.z > 1 && _verticalMvmtBiggerThanOther(vector);
  }

  static bool _isDownMovement(SensorVector3 vector){
    return vector.z < -1 && _verticalMvmtBiggerThanOther(vector);
  }

  static bool _sideMmntBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return sideMovement > dirMovement && sideMovement > verticalMovement;
  }

  static bool _dirMmntBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return dirMovement > sideMovement && dirMovement > verticalMovement;
  }

  static bool _verticalMvmtBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return verticalMovement > sideMovement && verticalMovement > dirMovement;
  }

  static MovementValue getHighestAccelerationValue(SensorVector3 vector){
    if(_sideMmntBiggerThanOther(vector)){
      var movementType = MovementType(fwd: false, bwd: false, right: vector.x > 0, left: vector.x < 0, up: false, down: false);
      return MovementValue(value: vector.x.abs(), direction: movementType);
    } else if (_dirMmntBiggerThanOther(vector)){
      var movementType = MovementType(fwd: vector.y > 0, bwd: vector.y < 0, right: false, left: false, up: false, down: false);
      return MovementValue(value: vector.y.abs(), direction: movementType);
    } else {
      var movementType = MovementType(fwd: false, left: false, right: false, bwd: false, up: vector.z > 0, down: vector.z < 0);
      return MovementValue(value: vector.z.abs(), direction: movementType);
    }
  }

  static MovementValue filterHighestValueFromList(List<SensorVector4> vectorList){
    var highestMovementValue = MovementValue(value: 0, direction: MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: false));

    vectorList.forEach((element) {
      var currentMovementValue = getHighestAccelerationValue(element);
      if(currentMovementValue.value > highestMovementValue.value){
        highestMovementValue = currentMovementValue;
      }
    });

    return highestMovementValue;
  }

  static MovementValue filterLowestValueFromList(List<SensorVector4> vectorList){
    var lowestMovementValue = MovementValue(value: pow(2, 50).toDouble(), direction: MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: false));

    vectorList.forEach((element) {
      var currentMovementValue = getHighestAccelerationValue(element);
      if(currentMovementValue.value < lowestMovementValue.value){
        lowestMovementValue = currentMovementValue;
      }
    });

    return lowestMovementValue;
  }

  static MovementValue filterAverageValueFromList(List<SensorVector4> vectorList) {
    var averageMovementValue = MovementValue(value: 0, direction: MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: false));

    List<MovementValue> movementValues = [];

    vectorList.forEach((element) {
      movementValues.add(getHighestAccelerationValue(element));
    });

    averageMovementValue.value = movementValues.map((m) => m.value).reduce((value, element) => value + element) / movementValues.length;

    return averageMovementValue;
  }
}