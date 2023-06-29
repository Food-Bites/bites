import 'package:flutter/material.dart';
import 'package:bites/data/social.dart';

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
      ],
    );
  }
}
