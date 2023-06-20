import 'dart:math';

import 'package:bites/data/italian_cities.dart';
import 'package:bites/utils/functions.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('I servizi per la posizione sono disabilitati');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('I permessi alla posizione sono stati negati');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'I permessi per la posizione sono stati negati in modo permanente ma sono necessari per l\'utilizzo dell\'app');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<String> findClosestCity() async {
  // Get current location
  final currentPosition = await determinePosition();
  final cities = await getCities();
  ItalianCities closestCity = cities[0];

  // Calculate distance to each city using Haversine formula
  double minDistance = double.infinity;
  for (final city in cities) {
    final lat1 = currentPosition.latitude;
    final lon1 = currentPosition.longitude;
    final lat2 = city.lat;
    final lon2 = city.lng;

    // Calculate distance
    const R = 6372.8; // In kilometers
    final dLat = toRad(lat2 - lat1);
    final dLon = toRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(toRad(lat1)) * cos(toRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * asin(sqrt(a));
    final distance = R * c;

    // Check if distance is the minimum
    if (distance < minDistance) {
      minDistance = distance;
      closestCity = city;
    }
  }

  return closestCity.city;
}
