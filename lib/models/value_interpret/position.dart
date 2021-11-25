import 'package:sensor_library/models/enums/length_unit.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';
import 'package:sensor_library/models/return_types/direction.dart';
import 'package:sensor_library/models/time_series.dart';
import 'package:sensor_library/models/value_interpret/sensor_type.dart';

class Position extends TimeSeries {
  late Barometer barometer;

  Position() {
    barometer = Barometer();
  }

  @override
  startTracking(int inMillis) {
    // barometer.startTracking(inMillis);
  }

  Direction getCurrentDirection() {
    return Direction(
        looksNorth: true,
        looksEast: false,
        looksSouth: false,
        looksWest: false);
  }

  double getCurrentHeading() {
    return 345;
  }

  Future<double> getAltitute(LengthUnit unit) async {
    var rawData = await barometer.getRaw().last;
    return rawData.hectpascal;
    // return rawData;
  }
}
