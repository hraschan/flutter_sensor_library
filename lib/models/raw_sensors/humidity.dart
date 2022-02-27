import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/services.dart';
import 'package:sensor_library/models/raw_sensors/sensor.dart';
import 'package:sensor_library/sensor_library.dart';

class Humidity extends Sensor {

  int inMillis;
  final _environmentSensors = EnvironmentSensors();

  Humidity({required this.inMillis}) {
    Library.checkIfOnWebProject();
    checkIfAvailable();
  }

  checkIfAvailable() async {
    if(!(await _environmentSensors.getSensorAvailable(SensorType.Humidity))){
      print("Humidity sensor not available.");
      throw PlatformException(code: "SENSOR_NOT_AVAILABLE", message: "Humidity sensor not available.");
    }
  }

  @override
  Stream<double> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return _environmentSensors.humidity.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<double> getRawWithoutTimelimit() {
    return _environmentSensors.humidity;
  }
}