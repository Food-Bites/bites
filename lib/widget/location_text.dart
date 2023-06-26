import 'package:bites/utils/location.dart';
import 'package:bites/widget/headline.dart';
import 'package:bites/widget/helper_text.dart';
import 'package:bites/widget/shimmer_headline.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          FutureBuilder(
            future: closestCity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Headline(
                    text: "Discover in", closestCity: snapshot.data as String);
              } else if (snapshot.hasError) {
                return const Text("your location");
              }
              return const ShimmerHeadline();
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          const HelperText(
            text: "Find the closest city to you",
            icon: Icons.info,
          ),
        ],
      ),
    );
  }
}
