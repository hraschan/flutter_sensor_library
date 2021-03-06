import 'package:flutter_compass/flutter_compass.dart';

import '../../sensor_library.dart';
import 'sensor.dart';

class Compass extends Sensor {
  int inMillis;
  
  Compass({required this.inMillis}) {
    Library.checkIfOnWebProject();
  }

  @override
  Stream<CompassEvent> getRaw() {
    var timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
    return FlutterCompass.events!.where((event) {
      if (DateTime.now().millisecondsSinceEpoch - timestampAtLastCall >
          inMillis) {
        timestampAtLastCall = DateTime.now().millisecondsSinceEpoch;
        return true;
      }
      return false;
    });
  }

  Stream<CompassEvent> getRawWithoutTimelimit() {
    return FlutterCompass.events!;
  }
  
}