class GpsPosition {
  double accuracy;
  double altitude;
  double heading;
  double latitude;
  double longitude;
  double speed;
  double speedAccuracy;
  double timestamp;

  GpsPosition({
    required this.accuracy, 
    required this.altitude, 
    required this.heading, 
    required this.latitude, 
    required this.longitude, 
    required this.speed, 
    required this.speedAccuracy, 
    required this.timestamp
    });
}