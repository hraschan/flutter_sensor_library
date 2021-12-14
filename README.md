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

```dart

// Initialize
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