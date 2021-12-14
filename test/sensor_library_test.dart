import 'package:flutter_test/flutter_test.dart';
import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/value_interpret/position.dart';
import 'package:sensor_library/sensor_library.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    // final position = Position();
    // position.startTracking(1000);
    // expect(position.getAltitute(LengthUnit.meter), )
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
