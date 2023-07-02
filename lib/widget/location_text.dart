import 'package:bites/utils/location.dart';
import 'package:bites/widget/headline.dart';
import 'package:flutter/material.dart';

/// The [LocationText] class is a widget that displays the location of the user.
/// {@category Widgets}
class LocationText extends StatefulWidget {
  const LocationText({super.key});

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  late Future<String> closestCity;

  @override
  void initState() {
    super.initState();
    BuildContext context = this.context;
    closestCity = getClosestCity(context);
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
                      text: "Discover in",
                      closestCity: snapshot.data as String);
                } else if (snapshot.hasError) {
                  return const Text("your location");
                }
                return const Headline(
                  closestCity: "your location",
                  text: "Discover in",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
