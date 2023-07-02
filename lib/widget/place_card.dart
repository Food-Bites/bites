import 'package:flutter/material.dart';

/// The [PlaceCard] class is a utility widget to display a card with a city name, latitude, and longitude.
/// It is used in the [MapView] class with [SearchBar].
/// {@category Widgets}
class PlaceCard extends StatelessWidget {
  final String city;
  final double latitude;
  final double longitude;
  final VoidCallback onTap;

  const PlaceCard({
    super.key,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(city),
        subtitle: Text('$latitude, $longitude'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
