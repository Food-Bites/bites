import 'package:bites/utils/location.dart';
import 'package:bites/widget/headline.dart';
import 'package:flutter/material.dart';

/// The [LocationText] class is a widget that displays the location of the user.
/// {@category Widgets}
class LocationText extends StatefulWidget {
  const LocationText({
    super.key,
    this.text = "Discover in",
    this.isSmall = false,
    this.lat = 0.0,
    this.lng = 0.0,
    this.hasCustomCity = false,
  });
  final String text;
  final bool hasCustomCity;
  final bool isSmall;
  final double lat;
  final double lng;

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  late Future<String> closestCity;

  @override
  void initState() {
    super.initState();
    BuildContext context = this.context;
    if (widget.hasCustomCity) {
      closestCity =
          getClosestCityByCoordinates(widget.lat, widget.lng, context);
    } else {
      closestCity = getClosestCityByCurrentLocation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: closestCity,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Headline(
                    text: widget.text,
                    closestCity: snapshot.data as String,
                    isSmall: widget.isSmall,
                  );
                } else if (snapshot.hasError) {
                  return const Text("your location");
                }
                return Headline(
                  closestCity: "your location",
                  text: widget.text,
                  isSmall: widget.isSmall,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
