import 'package:flutter/cupertino.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:bites/data/social.dart';


class Highlight extends StatelessWidget {
  final SocialFeed socialField;
  final _momentCount = 5;
  final _momentDuration = const Duration(seconds: 5);

  Highlight({super.key, required this.socialField});

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
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: Story(
                      onFlashForward: Navigator.of(context).pop,
                      onFlashBack: Navigator.of(context).pop,
                      momentCount: _momentCount,
                      momentDurationGetter: (idx) => _momentDuration,
                      momentBuilder: (context, idx) =>
                          Image.network(
                            socialField.photoURL,
                            fit: BoxFit.cover,
                          ),
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                image: DecorationImage(
                  image: Image.network(socialField.photoURL).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}