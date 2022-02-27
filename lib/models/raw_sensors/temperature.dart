import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/services.dart';
import 'package:sensor_library/models/raw_sensors/sensor.dart';

class Temperature extends Sensor {

  int inMillis;
  final _environmentSensors = EnvironmentSensors();

  Temperature({required this.inMillis}) {
    checkIfAvailable();
  }

  checkIfAvailable() async {
    if(!(await _environmentSensors.getSensorAvailable(SensorType.AmbientTemperature))){
      print("Temperature sensor not available.");
      throw PlatformException(code: "SENSOR_NOT_AVAILABLE", message: "Temperature sensor not available.");
    }
  }

  @override
  Stream<double> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return _environmentSensors.temperature.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall > inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }
}