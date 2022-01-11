library sensor_library;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
  int removeOne(int value) => value - 1;
  int resetValue() => 0;
}

class Library {
  static checkIfOnWebProject() {
    if(kIsWeb){
      print("Sensor Library not supported on Web projects.");
      throw PlatformException(code: "WEB_NOT_SUPPORTED", message: "Web is not supported for Sensor library");
    }
  }
}

