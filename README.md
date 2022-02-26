<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# Position

How to use:

You need to raise the MinSdkVersion for using the Position-based Sensor data.

In File android/app/build.gradle:
```dart
defaultConfig {
   applicationId "com.example.sensor_libary_test_app"
   minSdkVersion 23
   targetSdkVersion 30
   versionCode flutterVersionCode.toInteger()
   versionName flutterVersionName
}
```
Then you can use it in your dart-Files by importing and initializing it - for example in your initState() lifecycle method:
```dart
// Import
import 'package:sensor_library/models/value_interpret/position.dart';

// Initialize - for example in initState() lifecycle method
Position position = Position(inMillis: callbackTime);

```

## getCurrentHeading

Returns a double with the current heading (0-359, 0 is north)

```dart
position.getCurrentHeading().forEach((element) {
      print(element);
    });
```

## getCurrentDirection

Returns an Enum with the current direction(North, East, South, West)

```dart
position.getCurrentDirection().forEach((element) {
      print(element);
    });
```

# Not interpreted Sensors

## Gyro

```dart
Gyroscope gyro = Gyroscope(inMillis: intervalInMilliseconds);
gyro.getRaw().listen((element) {
   var x = element.x;
   // ...
   // Do your magic here
})
```

## Light

```dart
LightSensor lightSensor = LightSensor(inMillis: intervalInMilliseconds);
lightSensor.getRaw().listen((element) {
   var value = element;
   // ...
   // Do your magic here
})
```
