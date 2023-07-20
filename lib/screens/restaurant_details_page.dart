import 'package:android_intent/android_intent.dart';
import 'package:bites/data/social.dart';
import 'package:bites/utils/functions.dart';
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
                          child: SizedBox(
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
                                  imageUrl: socialFeed.photoURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: RestaurantDetails(socialFeed: socialFeed),
                        ),
                      ],
                    )
                  : Hero(
                      tag: socialFeed.name,
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
                          imageUrl: socialFeed.photoURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
              )
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
