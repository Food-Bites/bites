import 'package:bites/data/social.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stories/flutter_stories.dart';

class Highlight extends StatefulWidget {
  final SocialFeed socialField;

  const Highlight({Key? key, required this.socialField}) : super(key: key);

  @override
  State<Highlight> createState() => HighlightState();
}

class HighlightState extends State<Highlight> {
  final List<String> urls = [
    'https://raw.githubusercontent.com/Food-Bites/pictures/main/restaurants/noemi_ferrara.jpeg',
    'https://raw.githubusercontent.com/Food-Bites/pictures/main/restaurants/valle_dei_laghi.jpeg',
  ];

  double containerOpacity = 1.0; // Initial opacity

  final _momentCount = 2;
  final _momentDuration = const Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            border: Border.all(
              color: CupertinoColors.activeOrange,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          width: 64.0,
          height: 64.0,
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                containerOpacity = 0.5; // Change opacity on tap
              });

              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        Navigator.of(context).pop();
                        setState(() {
                          containerOpacity = 1.0; // Restore opacity on close
                        });
                      },
                      child: Story(
                        onFlashForward: () {
                          Navigator.of(context).pop();
                          setState(() {
                            containerOpacity = 1.0; // Restore opacity on close
                          });
                        },
                        onFlashBack: () {
                          Navigator.of(context).pop();
                          setState(() {
                            containerOpacity = 1.0; // Restore opacity on close
                          });
                        },
                        momentCount: _momentCount,
                        momentDurationGetter: (idx) => _momentDuration,
                        momentBuilder: (context, idx) => CachedNetworkImage(
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
                            fit: BoxFit.contain,
                          ),
                          imageUrl: urls[idx],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Opacity(
              opacity: containerOpacity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  image: DecorationImage(
                    image: Image.network(urls.first).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
