import 'package:flutter/material.dart';
import 'package:bites/data/social.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoverPopUp extends StatelessWidget {
  final SocialFeed socialFeed;

  const DiscoverPopUp({Key? key, required this.socialFeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(socialFeed.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address: ${socialFeed.address}'),
          const SizedBox(height: 8),
          Text('Phone: ${socialFeed.phone}'),
          const SizedBox(height: 8),
          Text('Email: ${socialFeed.email}'),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        GestureDetector(
          onTap: () {
            launchMapsUrl(socialFeed.latitude, socialFeed.longitude);
          },
          child: const TextButton(
            onPressed: null,
            child: Text('Open in Maps'),
          ),
        ),
      ],
    );
  }

  void launchMapsUrl(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
