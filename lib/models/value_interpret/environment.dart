import 'package:sensor_library/models/value_interpret/sensor_type.dart';

import '../../sensor_library.dart';

class Environment extends SensorType {

  Environment(){
    Library.checkIfOnWebProject();
  }

  Future<bool> listenOnProximity(int threshold, bool isApproaching) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  int getCurrentBrightness() {
    return 33;
  }
}