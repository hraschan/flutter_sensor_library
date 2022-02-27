import 'dart:math';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';
import 'package:sensor_library/models/raw_sensors/compass.dart';
import 'package:sensor_library/models/raw_sensors/temperature.dart';
import 'package:sensor_library/models/return_types/direction.dart';
import 'package:sensor_library/models/time_series.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

import '../../sensor_library.dart';

class Position extends TimeSeries {
  late Barometer barometer;
  late Temperature temperature;
  late Compass compass;
  int inMillis;

  Position({required this.inMillis}) {
    Library.checkIfOnWebProject();
    barometer = Barometer(inMillis: inMillis);
    compass = Compass(inMillis: inMillis);
    temperature = Temperature(inMillis: inMillis);
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

  Stream<double> getAltitute() {
    var barometerStream = barometer.getRawWithoutTimelimit();
    List<double> temperatures = [];
    temperature.getRawWithoutTimelimit().listen((event) {
      temperatures.add(event);
    });
    double p0 = 1013.25;

    Stream<double> altStream = barometerStream.map((event) {
      double alt = 0;
      double currentTempC = temperatures.isEmpty ? 15 : temperatures.last;
      double currentTempK = currentTempC + 273.15;
      double ph = event.hectpascal;
      
      var pressureQuotient = ph / p0;
      var exponent = 1 / 5.255;
      var pressureValue = pow(pressureQuotient, exponent);
      var temperatureValue = currentTempK / 0.0065;
      alt = temperatureValue * (1 - pressureValue);

      return alt;
    });

    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;

    return altStream.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }
}
