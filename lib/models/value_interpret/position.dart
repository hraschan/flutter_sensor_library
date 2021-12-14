import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';
import 'package:sensor_library/models/raw_sensors/compass.dart';
import 'package:sensor_library/models/return_types/direction.dart';
import 'package:sensor_library/models/time_series.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

class Position extends TimeSeries {
  late Barometer barometer;
  late Compass compass;

  Position({required int inMillis}) {
    // barometer = Barometer();
    compass = Compass(inMillis: inMillis);
  }

  @override
  startTracking(int inMillis) {
    // barometer.startTracking(inMillis);
  }

  Stream<Direction> getCurrentDirection() {
    return getCurrentHeading().asyncMap((event) => _mapCurrentDirection(event));
  }

  Stream<double> getCurrentHeading() {
    return compass.getRaw().asyncMap((event) => _mapCurrentHeading(event));
  }


  Direction _mapCurrentDirection(double  heading){
     
     if(heading <= 45){
       return Direction.north;
     }else if(heading <= 135){
       return Direction.east;
     }else if(heading <= 225){
       return Direction.south;
     }else if(heading <= 315){
       return Direction.west;
     }else {
       return Direction.north;
     }
  }

  /// Maps heading from Compass event
  double _mapCurrentHeading(CompassEvent event) {
    if (event.heading! < 0) {
      return event.heading! + 360;
    } else {
      return event.heading!;
    }
  }

  Future<double> getAltitute(LengthUnit unit) async {
    var rawData = await barometer.getRaw().last;
    return rawData.hectpascal;
    // return rawData;
  }
}
