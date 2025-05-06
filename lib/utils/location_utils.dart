import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationUtils {
  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Por favor, habilite o serviço de localização para que possamos obter as coordenadas do animal'
        )
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('As permissões de localização foram negadas',
              style: TextStyle(color: Colors.white),
            )
          )
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'As permissões de localização foram negadas, para enviar o registro é necessário habilitar a localização nas configurações do dispositivo',
          style: TextStyle(color: Colors.white),
        )
      ));
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) {
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      return '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

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

    final Position randomPosition = Position(
        latitude: randomPointLatLng.latitude,
        longitude: randomPointLatLng.longitude,
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