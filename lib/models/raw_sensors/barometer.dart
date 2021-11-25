import 'package:flutter_barometer_plugin/flutter_barometer.dart';

import 'sensor.dart';

class Barometer extends Sensor {
  @override
  Future<BarometerValue> getRaw() async {
    late BarometerValue rawData;
    return await FlutterBarometer.currentPressure;
  }

  // @override
  // startTracking(int inMillis) async {
  //   var seconds = (inMillis / 1000).round();
  //   return await BarometerPlugin.startBarometerListener(seconds);
  // }

  // @override
  // stopTracking() async {
  //   return await BarometerPlugin.stopBarometerListener();
  // }
}
