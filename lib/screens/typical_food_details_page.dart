import 'package:android_intent/android_intent.dart';
import 'package:bites/data/social.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:bites/utils/data_service.dart';
import 'package:bites/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// The [TypicalFoodDetailsPage] class is the page that displays the details of a typical food item.
/// {@category Screens}
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              isTablet(context)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: 256,
                            child: Hero(
                              tag: food.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  width: 256,
                                  useOldImageOnUrlChange: true,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/error.png',
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: food.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: TypicalFoodDetails(food: food),
                        ),
                      ],
                    )
                  : Hero(
                      tag: food.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          width: 256,
                          useOldImageOnUrlChange: true,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
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
              isTablet(context)
                  ? const SizedBox.shrink()
                  : TypicalFoodDetails(food: food),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Text(
                "Where to eat:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: DataService().getRestaurants(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SocialFeed> social = snapshot.data as List<SocialFeed>;
                    final foodId = food.id;
                    // filter the list of restaurants based on the food id
                    social = social
                        .where((element) => element.foods.contains(foodId))
                        .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: social.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  social[index].photoURL,
                                ),
                              ),
                              title: Text(
                                social[index].name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              subtitle: Text(
                                social[index].address,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _intentToGoogleMaps(
                                    social[index].latitude,
                                    social[index].longitude,
                                  );
                                },
                                icon: const Icon(Icons.directions),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TypicalFoodDetails extends StatelessWidget {
  const TypicalFoodDetails({super.key, required this.food});
  final TypicalFood food;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: isTablet(context)
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
