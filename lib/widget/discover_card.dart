import 'package:flutter/material.dart';
import 'package:bites/data/social.dart';

class DiscoverCard extends StatelessWidget {
  final SocialFeed socialFeed;
  final bool isLiked;
  final Animation<double>? animation;
  final VoidCallback onDoubleTap;
  final VoidCallback onPressedLike;
  final VoidCallback onPressedDetails;

  const DiscoverCard({
    Key? key,
    required this.socialFeed,
    required this.isLiked,
    this.animation,
    required this.onDoubleTap,
    required this.onPressedLike,
    required this.onPressedDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: GestureDetector(
                onTap: onPressedDetails,
                child: Text(
                  socialFeed.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onDoubleTap: onDoubleTap,
              child: Stack(
                children: [
                  Image.network(
                    socialFeed.photoURL,
                    fit: BoxFit.cover,
                  ),
                  if (isLiked && animation != null)
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: animation!,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 1.0 - animation!.value,
                            child: Transform.scale(
                              scale: animation!.value,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            ListTile(
              title: Text(socialFeed.name),
              subtitle: Text(socialFeed.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null,
                    ),
                    onPressed: onPressedLike,
                  ),
                  Text('Likes: ${socialFeed.likes}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
