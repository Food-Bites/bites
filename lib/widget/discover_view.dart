import 'package:flutter/material.dart';
import 'package:bites/widget/discover_card.dart';
import 'package:bites/widget/discover_pop_up.dart';
import 'package:bites/data/social.dart';

import '../data/social.dart';

class DiscoverView extends StatefulWidget {
  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView>
    with SingleTickerProviderStateMixin {
  //final List<SocialFeed> socialFeeds = SocialFeed.fromJson(socialFeed[key]);
  final List<String> liked = [];
  late AnimationController _animationController;
  late Map<ObjectKey, Animation<double>> _animationMap;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationMap = {};
  }

  void likeSocialFeed(ObjectKey key) {
    setState(() {
      final index =
      socialFeeds.indexWhere((socialFeed) => ObjectKey(socialFeed) == key);
      if (index != -1) {
        final socialFeed = socialFeeds[index];
        if (liked.contains(socialFeed.name)) {
          socialFeed.likes--;
          liked.remove(socialFeed.name);
          _animationMap.remove(key);
        } else {
          socialFeed.likes++;
          liked.add(socialFeed.name);
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
    return ListView.builder(
      itemCount: socialFeeds.length,
      itemBuilder: (context, index) {
        final socialFeed = socialFeeds[index];
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
