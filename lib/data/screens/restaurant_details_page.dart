import 'dart:math';

import 'package:android_intent/android_intent.dart';
import 'package:bites/data/social.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:bites/data/screens/typical_food_details_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/widget/magic_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({Key? key, required this.socialFeed})
      : super(key: key);
  final SocialFeed socialFeed;

  void _intentToGoogleMaps(String address) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: 'geo:0,0?q=$address',
      package: 'com.google.android.apps.maps',
    );
    intent.launch();
  }

  void _intentToPhone(String phone) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: 'tel:$phone',
    );
    intent.launch();
  }

  void _intentToMail(String email) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: 'mailto:$email',
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
                socialFeed.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              isTablet(context)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 256,
                                    child: Hero(
                                      tag: socialFeed.name,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          width: 256,
                                          useOldImageOnUrlChange: true,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
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
                                          imageUrl: socialFeed.photoURL[
                                              0], // Display the first image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ), // Add some spacing between images
                                  Row(
                                    children: List.generate(
                                      socialFeed.photoURL.length,
                                      (index) {
                                        if (index == 0) {
                                          return const SizedBox(); // Skip the first image
                                        }
                                        return Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                width: 256,
                                                imageUrl:
                                                    socialFeed.photoURL[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 6,
                          child: RestaurantDetails(socialFeed: socialFeed),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 256,
                            child: Hero(
                              tag: socialFeed.name,
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
                                  imageUrl: socialFeed
                                      .photoURL[0], // Display the first image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ), // Add some spacing between images
                          Row(
                            children: List.generate(
                              socialFeed.photoURL.length,
                              (index) {
                                if (index == 0) {
                                  return const SizedBox(); // Skip the first image
                                }
                                return Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        width: 256,
                                        imageUrl: socialFeed.photoURL[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )),
              isTablet(context)
                  ? const SizedBox.shrink()
                  : RestaurantDetails(
                      socialFeed: socialFeed,
                    ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      _intentToGoogleMaps(socialFeed.address);
                    },
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(16.0),
                    ),
                    icon: const HeroIcon(HeroIcons.mapPin),
                    label: Text(socialFeed.address),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _intentToPhone(socialFeed.phone);
                    },
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(16.0),
                    ),
                    icon: const HeroIcon(HeroIcons.phone),
                    label: Text(socialFeed.phone),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _intentToMail(socialFeed.email);
                    },
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(16.0),
                    ),
                    icon: const HeroIcon(HeroIcons.envelope),
                    label: Text(socialFeed.email),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "What to eat:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: fetchTypicalFoods(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<TypicalFood> foods =
                        snapshot.data as List<TypicalFood>;
                    // filter the list of foods based on the restaurant's id
                    foods = foods
                        .where(
                          (food) => food.restaurants.contains(socialFeed.id),
                        )
                        .toList();

                    if (foods.isEmpty) {
                      return const Center(
                        child: Column(
                          children: [
                            Text(
                                'No foods found! We are constantly adding new typical dishes. You may try using Google Maps to discover some restaurants.'),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // TODO implement check if food is already opened in the stack
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TypicalFoodDetailsPage(
                                      food: foods[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: MagicImage(food: foods[index]),
                                  ),
                                  title: Text(
                                    foods[index].name,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  trailing: const HeroIcon(
                                    HeroIcons.informationCircle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching data. Please try again.'),
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

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key, required this.socialFeed});
  final SocialFeed socialFeed;

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
              socialFeed.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class FakePicture extends StatelessWidget {
  const FakePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // random color for each fake picture
      color:
          Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
      margin: const EdgeInsets.all(8),
      width: 256,
      height: 256,
      child: const Center(child: Text("Altre immagini")),
    );
  }
}
