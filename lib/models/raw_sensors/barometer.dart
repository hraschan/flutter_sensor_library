import 'package:flutter_barometer_plugin/flutter_barometer.dart';

import 'sensor.dart';

class Barometer extends Sensor {
  @override
  BarometerValue getRaw()  {
    late BarometerValue rawData;
    FlutterBarometer.currentPressureEvent.listen((event) {
      rawData = event;
    });

    return rawData;
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
