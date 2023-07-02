import 'dart:math';

import 'package:bites/data/italian_cities.dart';
import 'package:bites/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied an [AlertDialog] is shown.
/// {@category Utils}
Future<Position> determinePosition(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return a modal to let the user know that the location services are disabled
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.location_off),
        content: const Text(
            "The location services are disabled. To use the app, enable location services."),
        actions: [
          TextButton(
            onPressed: () async {
              // Close the Dialog
              Navigator.of(context).pop();
              // Send the user to the location settings screen
              await Geolocator.openLocationSettings();
              // Retry the code after the user enables location services
              serviceEnabled = await Geolocator.isLocationServiceEnabled();
            },
            child: const Text('Open Location Settings'),
          ),
        ],
      ),
    );
    // show a snackbar to let the user to wait for the location services to be enabled
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(
          seconds: 15,
        ),
        showCloseIcon: true,
        content: Text(
            'Waiting for location services to start... This may take up to 30 seconds.'),
      ),
    );
    // return Future.error('I servizi di localizzazione sono disabilitati');
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
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.location_off),
          content: const Text(
              "The location access has been denied. To use the app, enable location access."),
          actions: [
            TextButton(
              onPressed: () async {
                // Close the Dialog
                Navigator.of(context).pop();
                // Send the user to the location settings screen
                await Geolocator.openAppSettings();
              },
              child: const Text('Open App Settings'),
            ),
          ],
        ),
      );
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error),
        content: const Text(
            "Location permissions have been permanently denied but are required to use the app."),
        actions: [
          TextButton(
            onPressed: () async {
              // Close the Dialog
              Navigator.of(context).pop();
              // Send the user to the location settings screen
              await Geolocator.openAppSettings();
            },
            child: const Text('Open App Settings'),
          ),
        ],
      ),
    );

    const LatLng milanCoordinates = LatLng(45.4642, 9.1900);

    return Position(
      latitude: milanCoordinates.latitude,
      longitude: milanCoordinates.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      isMocked: false,
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

/// The [getClosestCity] function returns the closest city to the user's current location.
/// {@category Utils}
Future<String> getClosestCity(BuildContext context) async {
  // Get current location
  final currentPosition = await determinePosition(context);
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
