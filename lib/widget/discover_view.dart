import 'package:bites/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:bites/widget/discover_card.dart';
import 'package:bites/widget/discover_pop_up.dart';
import 'package:bites/data/social.dart';
import '../utils/data_service.dart';
import 'package:bites/widget/discover_story.dart';
import 'package:geolocator/geolocator.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => DiscoverViewState();
}

class DiscoverViewState extends State<DiscoverView>
    with SingleTickerProviderStateMixin {
  late List<SocialFeed> socialFeeds = [];
  final DataService dataService = DataService();
  final List<String> liked = [];
  late AnimationController _animationController;
  late Map<ObjectKey, Animation<double>> _animationMap;
  late Position userPosition = Position(
    latitude: 45.4642,
    longitude: 9.1900,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    isMocked: false,
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationMap = {};

    getUserPosition();
  }

  fetchRestaurants() async {
    final fetchedRestaurants = await dataService.getRestaurants();
    return fetchedRestaurants;
  }

  void likeSocialFeed(ObjectKey key) {
    setState(() {
      final index =
          socialFeeds.indexWhere((restaurant) => ObjectKey(restaurant) == key);
      if (index != -1) {
        final restaurant = socialFeeds[index];
        if (liked.contains(restaurant.name)) {
          restaurant.likes--;
          liked.remove(restaurant.name);
          _animationMap.remove(key);
        } else {
          restaurant.likes++;
          liked.add(restaurant.name);
          _animationController.reset();
          _animationMap.forEach((k, animation) {
            if (k != key) {
              _animationController.reset();
              animation.removeStatusListener(_animationStatusListener);
            }
          });
          _animationMap.clear();
          _animationMap[key] = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          )..addStatusListener(_animationStatusListener);
          _animationController.forward();
        }
      }
    });
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _animationMap.clear();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: FutureBuilder(
          future: fetchRestaurants(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Highlights',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70, // Adjust the height as per your requirement
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final socialFeed = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Highlight(
                            socialField:
                                socialFeed, // Pass the images to the Highlight component
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final socialFeed = snapshot.data[index];
                      final isLiked = liked.contains(socialFeed.name);
                      final animationKey = ObjectKey(socialFeed);
                      final animation = _animationMap[animationKey];

                      return DiscoverCard(
                        key: animationKey,
                        socialFeed: socialFeed,
                        isLiked: isLiked,
                        animation: animation,
                        onDoubleTap: () => likeSocialFeed(animationKey),
                        onPressedLike: () => likeSocialFeed(animationKey),
                        onPressedDetails: () => showFeedItemDetails(socialFeed),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void showFeedItemDetails(SocialFeed socialFeed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DiscoverPopUp(socialFeed: socialFeed);
      },
    );
  }

  void getUserPosition() async {
    final position = await determinePosition(context);
    setState(() {
      userPosition = position;
    });
  }
}
