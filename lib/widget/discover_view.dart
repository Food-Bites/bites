import 'package:bites/utils/functions.dart';
import 'package:bites/widget/discover_story.dart';
import 'package:bites/widget/location_header.dart';
import 'package:flutter/material.dart';
import 'package:bites/widget/discover_card.dart';
import 'package:bites/widget/discover_pop_up.dart';
import 'package:bites/data/social.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../utils/data_service.dart';
import 'package:geolocator/geolocator.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => DiscoverViewState();
}

class DiscoverViewState extends State<DiscoverView> {
  late List<SocialFeed> socialFeeds = [];
  final DataService dataService = DataService();
  final List<String> liked = [];
  // get the user position in the next version
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

  fetchRestaurants() async {
    final fetchedRestaurants = await dataService.getRestaurants();
    return fetchedRestaurants;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      clipBehavior: Clip.none,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverPersistentHeader(
            delegate: LocationHeaderDelegate(text: "Discover in"),
            floating: false,
          ),
        ];
      },
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchRestaurants(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Events near you',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 70, // Adjust the height as per your requirement
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final socialFeed = snapshot.data[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Highlight(
                                socialField: socialFeed,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      StaggeredGrid.count(
                        crossAxisCount: isTablet(context) ? 3 : 1,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        children: snapshot.data.map<Widget>((socialFeed) {
                          final isLiked = liked.contains(socialFeed.name);
                          return DiscoverCard(
                            key: ValueKey(socialFeed.name),
                            socialFeed: socialFeed,
                            isLiked: isLiked,
                            onPressedDetails: () =>
                                showFeedItemDetails(socialFeed),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
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
}
