import 'package:android_intent/android_intent.dart';
import 'package:bites/screens/restaurant_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bites/data/social.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [DiscoverCard] widget displays a [SocialFeed] object.
/// It is used in the [DiscoverView] widget.
/// {@category Widgets}
class DiscoverCard extends StatefulWidget {
  final SocialFeed socialFeed;
  final bool isLiked;
  final VoidCallback onPressedDetails;

  const DiscoverCard({
    Key? key,
    required this.socialFeed,
    required this.isLiked,
    required this.onPressedDetails,
  }) : super(key: key);

  @override
  State<DiscoverCard> createState() => DiscoverCardState();
}

class DiscoverCardState extends State<DiscoverCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _controller;
  late Animation<double> _animation;

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
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    // retrieve the like status from shared preferences
    SharedPreferences.getInstance().then((prefs) {
      bool? isLiked = prefs.getBool(widget.socialFeed.name.toString());
      if (isLiked != null) {
        setState(() {
          _isLiked = isLiked;
          // update the likes count if the card was previously liked
          if (_isLiked) {
            widget.socialFeed.likes += 1;
          }
        });
      }
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _onDoubleTap() async {
    setState(() {
      _isLiked = !_isLiked;
      // add to widget.socialFeed.likes if _isLiked is true
      widget.socialFeed.likes += _isLiked ? 1 : -1;

      if (_isLiked) {
        _controller.reset();
        _controller.forward();
      }
    });

    // save the like status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.socialFeed.name.toString(), _isLiked);
  }

  void _onTapDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsPage(
          socialFeed: widget.socialFeed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapDetails,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: widget.onPressedDetails,
                child: Text(
                  widget.socialFeed.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: GestureDetector(
                    onDoubleTap: _onDoubleTap,
                    child: Hero(
                      tag: widget.socialFeed.name,
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
                        imageUrl: widget.socialFeed.photoURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (_isLiked)
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 1.0 - _animation.value,
                          child: Transform.scale(
                            scale: _animation.value,
                            child: const HeroIcon(
                              HeroIcons.heart,
                              color: Colors.red,
                              size: 100.0,
                              style: HeroIconStyle.solid,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : null,
                      ),
                      onPressed: _onDoubleTap,
                    ),
                    Text('${widget.socialFeed.likes}'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                  child: Wrap(
                    children: [
                      Text(widget.socialFeed.description),
                    ],
                  ),
                ),
                const Divider(),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _intentToGoogleMaps(widget.socialFeed.address);
                      },
                      style: ButtonStyle(
                        iconSize: MaterialStateProperty.all(16.0),
                      ),
                      icon: const HeroIcon(HeroIcons.mapPin),
                      label: Text(widget.socialFeed.address),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _intentToPhone(widget.socialFeed.phone);
                      },
                      style: ButtonStyle(
                        iconSize: MaterialStateProperty.all(16.0),
                      ),
                      icon: const HeroIcon(HeroIcons.phone),
                      label: Text(widget.socialFeed.phone),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _intentToMail(widget.socialFeed.email);
                      },
                      style: ButtonStyle(
                        iconSize: MaterialStateProperty.all(16.0),
                      ),
                      icon: const HeroIcon(HeroIcons.envelope),
                      label: Text(widget.socialFeed.email),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
