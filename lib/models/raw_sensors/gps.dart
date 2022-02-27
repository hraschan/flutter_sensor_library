
import 'package:flutter/services.dart';
import 'package:sensor_library/models/raw_sensors/sensor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensor_library/models/return_types/gps_position.dart';

import '../../sensor_library.dart';

class Gps extends Sensor {

  int inMillis;

  Gps({required this.inMillis}) {
    Library.checkIfOnWebProject();
    checkIfSensorEnabled();
  }

  checkIfSensorEnabled() async {
    if(!(await Geolocator.isLocationServiceEnabled())){
      print("GPS sensor not available/enabled.");
      throw PlatformException(code: "SENSOR_NOT_AVAILABLE", message: "GPS sensor not available/enabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        print("User has denied location permission.");
        throw Exception("User has denied location permission.");
      }
    }

    if(permission == LocationPermission.deniedForever){
      print("User has denied location permission permanently.");
      throw Exception("User has denied location permission permanently.");
    }
  }

  // type not specified as the library 
  // provides more raw data than covered by one method
  @override
  Stream<GpsPosition> getRaw() {
    var mappedStream = Geolocator.getPositionStream().map((event) {
      return GpsPosition(
        accuracy: event.accuracy, 
        altitude: event.altitude, 
        heading: event.heading, 
        latitude: event.latitude, 
        longitude: event.longitude, 
        speed: event.speed, 
        speedAccuracy: event.speedAccuracy, 
        timestamp: event.timestamp!.millisecondsSinceEpoch.toDouble()
      );
    });

    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;

    return mappedStream.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }
  
}