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

# Flutter Sensor Library

   [Usage Informations](#usage-informations)  
   [Interpreted Sensor-Data](#interpreted-sensor-data)  
   [Not interpreted / Raw Sensors](#not-interpreted--raw-sensors)  


# Usage informations

## Position & GPS
You need to raise the MinSdkVersion and the compileSdkVersion for using the Position-based Sensor data.

In File android/app/build.gradle:
```dart
android {
   compileSdkVersion 31
   
   defaultConfig {
      applicationId "com.example.sensor_libary_test_app"
      minSdkVersion 23
      targetSdkVersion 30
      versionCode flutterVersionCode.toInteger()
      versionName flutterVersionName
   }
}
```

## GPS only:

If you want to use GPS-Data, you need to grant location-permissions in your Android (Manifest) or iOS App.

### Permissions - Android

On Android you'll need to add either the ACCESS_COARSE_LOCATION or the ACCESS_FINE_LOCATION permission to your Android Manifest. To do so open the AndroidManifest.xml file (located under android/app/src/main) and add one of the following two lines as direct children of the <manifest> tag (when you configure both permissions the ACCESS_FINE_LOCATION will be used by the GPS):

```dart
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```
Starting from Android 10 you need to add the ACCESS_BACKGROUND_LOCATION permission (next to the ACCESS_COARSE_LOCATION or the ACCESS_FINE_LOCATION permission) if you want to continue receiving updates even when your App is running in the background (note that the geolocator plugin doesn't support receiving an processing location updates while running in the background):

   
```dart
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
```
NOTE Specifying the ACCESS_COARSE_LOCATION permission results in location updates with an accuracy approximately equivalent to a city block. It might take a long time (minutes) before you will get your first locations fix as ACCESS_COARSE_LOCATION will only use the network services to calculate the position of the device.
   
### Permissions - iOS
   
On iOS you'll need to add the following entries to your Info.plist file (located under ios/Runner) in order to access the device's location. Simply open your Info.plist file and add the following (make sure you update the description so it is meaningfull in the context of your App):

```
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>
```

If you would like to receive updates when your App is in the background, you'll also need to add the Background Modes capability to your XCode project (Project > Signing and Capabilities > "+ Capability" button) and select Location Updates. Be careful with this, you will need to explain in detail to Apple why your App needs this when submitting your App to the AppStore. If Apple isn't satisfied with the explanation your App will be rejected.

When using the requestTemporaryFullAccuracy({purposeKey: "YourPurposeKey"}) method, a dictionary should be added to the Info.plist file.
```
<key>NSLocationTemporaryUsageDescriptionDictionary</key>
<dict>
  <key>YourPurposeKey</key>
  <string>The example App requires temporary access to the device&apos;s precise location.</string>
</dict>
```
The second key (in this example called YourPurposeKey) should match the purposeKey that is passed in the requestTemporaryFullAccuracy() method. It is possible to define multiple keys for different features in your app. More information can be found in Apple's documentation.

NOTE: the first time requesting temporary full accuracy access it might take several seconds for the pop-up to show. This is due to the fact that iOS is determining the exact user location which may take several seconds. Unfortunately this is out of our hands.

# Interpreted Sensor-Data
   
## Position

You can use it in your dart-Files by importing and initializing it - for example in your initState() lifecycle method:
```dart
// Import
import 'package:sensor_library/models/value_interpret/position.dart';

// Initialize - for example in initState() lifecycle method
Position position = Position(inMillis: callbackTime);

```

### ```Stream<Direction>``` getCurrentDirection

Returns an Enum with the current direction(North, East, South, West)

```dart
position.getCurrentDirection().listen((element) {
   // e.g.:
   bool isNorth = element == Direction.north;
   // ...
   // Do your magic here
});
```
   
### ```Stream<double>``` getCurrentHeading

Returns a double with the current heading (0-359, 0 is north)

```dart
position.getCurrentHeading().listen((element) {
   var value = element;
   // ...
   // Do your magic here
});
```

### ```Stream<double>``` getCurrentHeadingByGPSPosition
   
See above: The value is not derived from compass sensor but from GPS.
   
### ```Stream<double>``` getAltitude

Returns a stream of double values for the current altitude from sea level, derived from air pressure and temperature

```dart
   position.getAltitude().listen((element) {
      var altitude = element;
      // ...
      // Do your magic here
   }
```

### ```Stream<double>``` getAltitudeByGPSPosition

Returns a stream of double values for the current altitude from sea level, derived from GPS position

```dart
   position.getAltitudeByGPSPosition().listen((element) {
      var altitude = element;
      // ...
      // Do your magic here
   }
```

# Not interpreted / Raw Sensors

## Accelerometer

### ```Stream<SensorVector3>``` getRaw

```dart
   Accelerometer acc = Accelerometer(inMillis: intervalInMilliseconds);
   acc.getRaw().listen((element) {
      var x = element.x;
      // ...
      // Do your magic here
   })
```

## Barometer

### ```Stream<BarometerValue>``` getRaw

```dart
   Barometer baro = Barometer(inMillis: intervalInMilliseconds);
   baro.getRaw().listen((element) {
      double valueInHectopascal = element.hectpascal;
      double valueInMMMercury = element.millimeterOfMercury;
      // ..
      // Do your magic here
   });
```

## Compass

### ```Stream<CompassEvent>``` getRaw

```dart
   Compass compass = Compass(inMillis: intervalInMilliseconds);
   compass.getRaw().listen((element) {
      double heading = element.heading;
      double accuracy = element.accuracy;
      // ..
      // Do your magic here
   });
```

## GPS

### ```Stream<GpsPosition>``` getRaw
   
```dart
Gps gps = Gps(inMillis: intervalInMilliseconds);
gps.getRaw().listen((element) {
   var altitude = element.altitude;
   var heading = element.heading;
   var speed = element.speed;
   var latitude = element.latitude;
   var longitude = element.longitude;
   // ...
   // Do your magic here
})
```

## Gyroscope

### ```Stream<SensorVector3>``` getRaw

```dart
Gyroscope gyro = Gyroscope(inMillis: intervalInMilliseconds);
gyro.getRaw().listen((element) {
   var x = element.x;
   // ...
   // Do your magic here
})
```

## Humidity

### ```Stream<double>``` getRaw
Fires only when changed

```dart
   Humidity hum = Humidity(inMillis: intervalInMilliseconds);
   hum.getRaw().listen((element) {
      double value = element;
      // ...
      // Do your magic here
   });
```

## Light

### ```Stream<int>``` getRaw
Fires only when changed

```dart
LightSensor lightSensor = LightSensor(inMillis: intervalInMilliseconds);
lightSensor.getRaw().listen((element) {
   var value = element;
   // ...
   // Do your magic here
})
```

## Proximity / LIDAR

Not supported yet.

## Temperature

### ```Stream<double>``` getRaw
Fires only when changed

```dart
   Temperature temp = Temperature(inMillis: intervalInMilliseconds);
   temp.getRaw().listen((element) {
      double value = element;
      // ...
      // Do your magic here
   });
```
