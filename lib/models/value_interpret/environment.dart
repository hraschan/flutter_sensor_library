import 'package:sensor_library/models/raw_sensors/light_sensor.dart';
import 'package:sensor_library/models/return_types/sensor_vector_4.dart';
import 'package:sensor_library/models/return_types/time_value.dart';
import 'package:sensor_library/models/utils/time_value_utils.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

import '../../sensor_library.dart';

class Environment extends SensorType {

  LightSensor _lightSensor = LightSensor(inMillis: 0);
  int inMillis;
  List<TimeValue> _brightnessList = [];

  Environment({required this.inMillis}){
    Library.checkIfOnWebProject();
    _lightSensor = LightSensor(inMillis: inMillis);
  }

  @override
  startTracking(){
    _lightSensor.getRaw().forEach((element) {
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      _brightnessList.add(TimeValue(value: element.toDouble(), time: currentTime.toDouble()));
    });
  }

  Future<bool> listenOnProximity(int threshold, bool isApproaching) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  TimeValue getBrightnessAtTimestamp(DateTime time) {
    if(_brightnessList.isEmpty){
      throw Exception("No List to get data from: Recording not started");
    }
    var timestamp = time.millisecondsSinceEpoch;
    var exactElement = TimeValue(value: 0, time: 0);
    try {
      exactElement = _brightnessList.firstWhere((element) => element.time == timestamp);
    } on StateError {
      exactElement = _brightnessList.firstWhere((element) => element.time >= timestamp - inMillis && element.time <= timestamp + inMillis);
    }

    return exactElement;
  }

  TimeValue getMaxBrightness() {
    return TimeValueUtils.filterHighestValueFromList(_brightnessList);
  }

  TimeValue getMinBrightness() {
    return TimeValueUtils.filterLowestValueFromList(_brightnessList);
  }

  TimeValue getAvgBrightness() {
    return TimeValueUtils.filterAverageValueFromList(_brightnessList);
  }
}