import 'sensor.dart';
import 'package:barometer_plugin/barometer_plugin.dart';

class Barometer extends Sensor {
  @override
  Future<double> getRaw() async {
    var list = await BarometerPlugin.getBarometerData();
    return list[list.length - 1];
  }

  @override
  startTracking(int inMillis) async {
    var seconds = (inMillis / 1000).round();
    return await BarometerPlugin.startBarometerListener(seconds);
  }

  @override
  stopTracking() async {
    return await BarometerPlugin.stopBarometerListener();
  }
}
