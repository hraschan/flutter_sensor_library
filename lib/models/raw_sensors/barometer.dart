import 'package:flutter_barometer_plugin/flutter_barometer.dart';

import 'sensor.dart';

class Barometer extends Sensor {
  
   @override
   Stream<BarometerValue> getRaw()  {
    return FlutterBarometer.currentPressureEvent;

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
