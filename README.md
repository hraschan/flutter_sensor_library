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

This is a sensor library for Flutter, containing several native sensors to get raw data from and providing also interpreted data.  
There is an example application where we showed all of the functionality of this library in use.  
[Example-App on Github](https://github.com/hraschan/flutter_sensor_library_app)  
[Download Example-APK for Android](#)

   [Usage Informations](#usage-informations)  
   [Interpreted Sensor-Data](#interpreted-sensor-data)  
   &nbsp;&nbsp;&nbsp;[Environment](#environment)  
   &nbsp;&nbsp;&nbsp;[Movement](#movement)  
   &nbsp;&nbsp;&nbsp;[Position](#position)  
   [Not interpreted / Raw Sensors](#not-interpreted--raw-sensors)  
   &nbsp;&nbsp;&nbsp;[Accelerometer](#accelerometer)  
   &nbsp;&nbsp;&nbsp;[Barometer](#barometer)  
   &nbsp;&nbsp;&nbsp;[Compass](#compass)  
   &nbsp;&nbsp;&nbsp;[GPS](#gps)  
   &nbsp;&nbsp;&nbsp;[Gyroscope](#gyroscope)  
   &nbsp;&nbsp;&nbsp;[Humidity](#humidity)  
   &nbsp;&nbsp;&nbsp;[Light](#light)  
   &nbsp;&nbsp;&nbsp;[Proximity / Lidar](#proximity--lidar)  
   &nbsp;&nbsp;&nbsp;[Temperature](#temperature)  


# Usage informations

## Installation

[pub.dev Page](https://pub.dev/packages/sensor_library)

```flutter pub add sensor_library```

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
  
## Environment
   
   You can use it in your dart-Files by importing and initializing it - for example in your initState() lifecycle method:
   
   ```dart
   // Import
   import 'package:sensor_library/models/value_interpret/environment.dart';

   // Initialize - for example in initState() lifecycle method
   Environment env = Environment(inMillis: callbackTime);

   ```
   
### ```void``` startTracking
   
   Initializes the tracking of the brightness values from light sensor. Once you started the tracking, you can receive max, min and avg value since tracking started or receive the brightness at a given timestamp.
   Not supported for Proximity / LIDAR-sensor.
   
   ```dart
      env.startTracking();
   ```
   
### ```TimeValue``` getMaxBrightness
   
   Returns the maximum value and timestamp of brightness since ```startTracking()``` was started.
   
   ```dart
      env.getMaxBrightness();
   ```
   
### ```TimeValue``` getMinBrightness
   Returns the minimum value and timestamp of brightness since ```startTracking()``` was started.
   Example: see above
   
### ```TimeValue``` getAvgBrightness
   Returns the average value of brightness since ```startTracking()``` was started. Timestamp is not given in this case
   Example: see above
   
### ```TimeValue``` getBrightnessAtTimestamp
   Returns the value and timestamp of brightness at a given timestamp, when ```startTracking()``` was started before.
   Example: see above
 
## Movement
   
You can use it in your dart-Files by importing and initializing it - for example in your initState() lifecycle method:
   
   ```dart
   // Import
   import 'package:sensor_library/models/value_interpret/movement.dart';

   // Initialize - for example in initState() lifecycle method
   Movement movement = Movement(inMillis: callbackTime);

   ```
   
### ```void``` startTracking()
   
   Only supported for Accelerometer Sensor at the moment.
   Initializes the tracking of the acceleration values. Once you started the tracking, you can receive max, min and avg value since tracking started or receive the acceleration at a given timestamp.
   
   ```dart
      movement.startTracking();
   ```  
   [Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_recording_route.dart)
### ```MovementValue``` getAccelerationAtTimestamp(DateTime)
   
   Returns direction and amount of movement at the given timestamp.
   
   ```dart
      var currentMovement = movement.getAccelerationAtTimestamp(currentDateTime);
      bool isNorth = currentMovement.direction == Direction.north;
      double value = currentMovement.value;
   ```
   [Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_recording_route.dart)
### ```MovementValue``` getMaxAcceleration()
   
   Returns direction and amount of movement of the biggest movement since ```startTracking()``` was called.  
   How to: see right above.  
   [Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_recording_route.dart)
   
### ```MovementValue``` getAvgAcceleration()
   Returns amount of movement of the average movement since ```startTracking()``` was called.  
   How to: see above.  
   [Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_recording_route.dart)
   
### ```MovementValue``` getMinAcceleration()
   Returns direction and amount of movement of the smallest movement since ```startTracking()``` was called.  
   How to: see above.  
   [Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_recording_route.dart)
   
### ```Stream<MovementValue>``` getAcceleration()
   Returns a stream of MovementValues with direction and amount of current movement.  
   How to: see above.
### ```Stream<double>``` getVelocity()
   Returns a Stream of doubles on the current velocity.
   
   ```dart
       movement.getVelocity().listen((event) {
         double value = event;
         // ..
         // do your magic here
      });
   ```
### ```Stream<bool>``` listenOnVelocity(double threshold)
   Not implemented yet.

### ```Stream<MovementType>``` getMovementType(bool interpolatedSinceLastCall)
   Returns the type of movement the sensor has tracked.   
   When ```interpolatedSinceLastCall``` is true, the values are gathered since the last call.
   
   ```dart
       movement.getMovementType(true).listen((event) {
         var isForwardMovement = event.fwd;
         // ...
         // do your magic here
      });
   ```
### ```void``` setTransformValue(double relativeNull)
   NOT SUPPORTED YET.  
   Sets the relative zero for all captured data.

## Position

You can use it in your dart-Files by importing and initializing it - for example in your initState() lifecycle method:
```dart
// Import
import 'package:sensor_library/models/value_interpret/position.dart';

// Initialize - for example in initState() lifecycle method
Position position = Position(inMillis: callbackTime);

```
   
### ```void``` startTracking
   
Not supported yet.  
Preview: with this method you could track the values of Barometer, Temperature, Compass and Gps-Data and afterwards get Entries by timestamp, get the entry with max, min and average values.

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
[Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/kompass_route.dart)
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
[Example Usage in our App on Github](https://github.com/hraschan/flutter_sensor_library_app/blob/master/lib/routes/accelerometer_route.dart)
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

### ```Stream<int>``` getRaw
   
   Fires only on changes  
   Returns 1 if nearer than 1cm, else 0.
   
   ```dart
      prox.getRawWithoutTimelimit().listen((event) {print(event);});
   ```

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
