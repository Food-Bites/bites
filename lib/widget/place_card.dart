import 'package:flutter/material.dart';

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
