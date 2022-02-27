import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/raw_sensors/accelerometer.dart';
import 'package:sensor_library/models/return_types/movement_type.dart';
import 'package:sensor_library/models/return_types/movement_value.dart';
import 'package:sensor_library/models/return_types/sensor_vector_4.dart';
import '../return_types/sensor_vector_3.dart';
import 'package:sensor_library/models/time_series.dart';
import 'package:sensor_library/models/utils/movement_type_utils.dart';
import 'package:sensor_library/sensor_library.dart';


class Movement extends TimeSeries {
  
  late Accelerometer  _accelerometer; 
  int inMillis;
  final SensorVector3 _saveVector = SensorVector3(x: 0, y: 0, z: 0);
  final List<SensorVector4> _vectorList = [];

  @override
  startTracking(int inMillis) {
    _accelerometer = Accelerometer(inMillis:inMillis);
    this.inMillis = inMillis;

    _accelerometer.getRaw().forEach((element) {
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      var sensorWithTime = SensorVector4(x: element.x, y: element.y, z: element.z, time: currentTime.toDouble());
      _vectorList.add(sensorWithTime);
    });
  }

  Movement({required this.inMillis}){
    Library.checkIfOnWebProject();
    _accelerometer = Accelerometer(inMillis: inMillis);
  }

  void setTransformValue(double relativeNull) {}

  Stream<MovementType> getMovementType(bool interpolatedSinceLastCall) {
    if(interpolatedSinceLastCall){
      Stream<SensorVector3> interpolatedStream = _mapSensorVectorToInterpolatedValues(_accelerometer.getRawWithoutTimeLimit());
      return MovementTypeUtils.mapSensorVectorToMovementType(interpolatedStream);
    }
    return MovementTypeUtils.mapSensorVectorToMovementType(_accelerometer.getRaw());
  }

  Stream<SensorVector3> _mapSensorVectorToInterpolatedValues(Stream<SensorVector3> rawStream){
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    var timestampForCalls = DateTime.now().millisecondsSinceEpoch;

    var mappedStream = rawStream.map((event) {
      if(DateTime.now().millisecondsSinceEpoch - timestampAtLastCall >
          inMillis) {
        print("Is in Time, Vector: " + (_saveVector.x+event.x).toString() + (_saveVector.y+event.y).toString() + (_saveVector.z+event.z).toString());
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        var mappedVector = SensorVector3(x: event.x + _saveVector.x, y: event.y + _saveVector.y, z: event.z + _saveVector.z);
        _saveVector.x = 0;
        _saveVector.y = 0;
        _saveVector.z = 0;
        return mappedVector;
      } else {
        _saveVector.x += event.x;
        _saveVector.y += event.y;
        _saveVector.z += event.z;
        return SensorVector3(x: 0, y: 0, z: 0);
      }
    });

    return mappedStream.where((event) {
      if(DateTime.now().millisecondsSinceEpoch - timestampForCalls 
        > inMillis) {
        print("----------------TRUE--------------");
        timestampForCalls = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      print("------------------FALSE-------------");
      return false;
    });
  }

  Future<bool> listenOnDirection(MovementType movementType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  SensorVector3 getMovementVector() {
    return SensorVector3(x: 10, y: 15, z: 2);
  }

  List<double> getVelocity(LengthUnit lengthUnit) {
    List<double> velo = [];
    velo.add(22.5);
    velo.add(25.7);
    velo.add(30.2);
    return velo;
  }

  double getVelocityAtTimestamp(LengthUnit lengthUnit, DateTime timestamp) {
    return 22.5;
  }

  Future<bool> listenOnVelocity(double threshold) async {
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

  MovementValue getAccelerationAtTimestamp(DateTime time) {
    if(_vectorList.isEmpty){
      throw Exception("No List to get data from: Recording not started");
    }
    var timestamp = time.millisecondsSinceEpoch;
    var exactElement = SensorVector4(x: 0, y: 0, z: 0, time: 0);
    try {
      exactElement = _vectorList.firstWhere((element) => element.time == timestamp);
    } on StateError {
      exactElement = _vectorList.firstWhere((element) => (element.time >= timestamp - inMillis) && element.time <= timestamp + inMillis);
    }
    return MovementTypeUtils.getHighestAccelerationValue(exactElement);
  }

  MovementValue getMaxAcceleration() {
    if(_vectorList.isEmpty){
      throw Exception("No List to get data from: Recording not started");
    }
    return MovementTypeUtils.filterHighestValueFromList(_vectorList);
  }

  MovementValue getAvgAcceleration() {
    if(_vectorList.isEmpty){
      throw Exception("No List to get data from: Recording not started");
    }
    return MovementTypeUtils.filterAverageValueFromList(_vectorList);
  }

  MovementValue getMinAcceleration() {
    if(_vectorList.isEmpty){
      throw Exception("No List to get data from: Recording not started");
    }
    return MovementTypeUtils.filterLowestValueFromList(_vectorList);
  }
}
