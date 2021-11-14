import 'package:sensor_library/models/value_interpret/sensor_type.dart';

class Environment extends SensorType {
  Future<bool> listenOnProximity(int threshold, bool isApproaching) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  int getCurrentBrightness() {
    return 33;
  }
}