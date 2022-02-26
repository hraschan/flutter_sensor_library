import 'dart:math';

import 'package:sensor_library/models/return_types/time_value.dart';

class TimeValueUtils {
  static TimeValue filterHighestValueFromList(List<TimeValue> list){
    var highestValue = TimeValue(value: 0, time: 0);

    list.forEach((element) {
      if(element.value > highestValue.value){
        highestValue = element;
      }
    });

    return highestValue;
  }

  static TimeValue filterLowestValueFromList(List<TimeValue> list){
    var lowestValue = TimeValue(value: pow(2,50).toDouble(), time: 0);

    list.forEach((element) {
      if(element.value < lowestValue.value){
        lowestValue = element;
      }
    });

    return lowestValue;
  }

  static TimeValue filterAverageValueFromList(List<TimeValue> list){
    var averageValue = TimeValue(value: 0, time: 0);

    averageValue.value = list.map((m) => m.value).reduce((value, element) => value + element) / list.length;

    return averageValue;
  }
}