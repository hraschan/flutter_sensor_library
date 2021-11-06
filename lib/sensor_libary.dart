library sensor_libary;

import 'dart:ffi';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
  int removeOne(int value) => value - 1;
  int resetValue() => 0;
}

class Barometer {
  double getPressure() => 12312.76;
}
