import 'package:sensor_library/models/return_types/movement_type.dart';
import 'package:sensor_library/models/return_types/sensor_vector_3.dart';

class MovementTypeUtils {

  static Stream<MovementType> mapSensorVectorToMovementType(Stream<SensorVector3> stream) {
    return stream
        .asyncMap((event) {
          if(isFwdMovement(event)){
            print("fwd");
            return MovementType(fwd: true, left: false, right: false, bwd: false, up: false, down: false);
          } else if(isBwdMovement(event)){
            print("bwd");
            return MovementType(fwd: false, left: false, right: false, bwd: true, up: false, down: false);
          } else if(isLeftMovement(event)){
            print("lwd");
            return MovementType(fwd: false, left: true, right: false, bwd: false, up: false, down: false);
          } else if(isRightMovement(event)){
            print("rwd");
            return MovementType(fwd: false, left: false, right: true, bwd: false, up: false, down: false);
          } else if(isUpMovement(event)){
            print("up");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: true, down: false);
          } else if(isDownMovement(event)){ 
            print("down");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: true);
          } else {
            print("no movement");
            return MovementType(fwd: false, left: false, right: false, bwd: false, up: false, down: false);
          }
        });
  }

  static bool isFwdMovement(SensorVector3 vector){
    return vector.y > 1 && dirMmntBiggerThanOther(vector);
  }

  static bool isBwdMovement(SensorVector3 vector){
    return vector.y < -1 && dirMmntBiggerThanOther(vector);
  }

  static bool isLeftMovement(SensorVector3 vector){
    return vector.x < -1 && sideMmntBiggerThanOther(vector);
  }

  static bool isRightMovement(SensorVector3 vector){
    return vector.x > 1 && sideMmntBiggerThanOther(vector);
  }

  static bool isUpMovement(SensorVector3 vector){
    return vector.z > 1 && verticalMvmtBiggerThanOther(vector);
  }

  static bool isDownMovement(SensorVector3 vector){
    return vector.z < -1 && verticalMvmtBiggerThanOther(vector);
  }

  static bool sideMmntBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return sideMovement > dirMovement && sideMovement > verticalMovement;
  }

  static bool dirMmntBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return dirMovement > sideMovement && dirMovement > verticalMovement;
  }

  static bool verticalMvmtBiggerThanOther(SensorVector3 vector){
    var dirMovement = vector.y.abs();
    var sideMovement = vector.x.abs();
    var verticalMovement = vector.z.abs();
    return verticalMovement > sideMovement && verticalMovement > dirMovement;
  }
}