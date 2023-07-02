import 'package:android_intent/android_intent.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TypicalFoodDetailsPage extends StatelessWidget {
  const TypicalFoodDetailsPage({Key? key, required this.food})
      : super(key: key);
  final TypicalFood food;

  void _intentToGoogleMaps(latitude, longitude) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: 'geo:$latitude,$longitude',
      package: 'com.google.android.apps.maps',
    );
    intent.launch();
  }

  // TODO fix the UI of this page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              food.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                useOldImageOnUrlChange: true,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/error.png',
                  fit: BoxFit.cover,
                ),
                imageUrl: food.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // add an elevated button which makes an intent to open google maps with the location of the food
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                _intentToGoogleMaps(food.latitude, food.longitude);
              },
              child: const Text('Find it on Google Maps'),
            ),
          ),
        ],
      ),
    );
  }
}
