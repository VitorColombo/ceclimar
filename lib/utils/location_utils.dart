import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationUtils {
  Position getRandomPositionInRadius(double lat, double long, double radiusInMeters) {
    if (radiusInMeters <= 0) {
      throw ArgumentError("Radius must be positive.");
    }

    final Random random = Random();
    final LatLng centerPointLatLng = LatLng(lat, long);

    final double randomBearingDegrees = random.nextDouble() * 360.0;

    final double u = random.nextDouble();
    final double randomDistanceInMeters = radiusInMeters * sqrt(u);

    const Distance distanceCalculator = Distance();

    final LatLng randomPointLatLng = distanceCalculator.offset(
      centerPointLatLng,
      randomDistanceInMeters,
      randomBearingDegrees,
    );

    final double roundedLat = double.parse(randomPointLatLng.latitude.toStringAsFixed(7));
    final double roundedLng = double.parse(randomPointLatLng.longitude.toStringAsFixed(7));

    final Position randomPosition = Position(
        latitude: roundedLat,
        longitude: roundedLng,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
      
    return randomPosition;
  }
}