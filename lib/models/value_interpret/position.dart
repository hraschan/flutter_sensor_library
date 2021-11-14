import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/return_types/direction.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

class Position extends SensorType {
  Direction getCurrentDirection() {
    return Direction(looksNorth: true, looksEast: false, looksSouth: false, looksWest: false);
  }

  double getCurrentHeading() {
    return 345;
  }

  double getAltitute(LengthUnit unit) {
    return 329.25;
  }
}