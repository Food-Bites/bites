import 'package:flutter/material.dart';
import 'package:bites/data/social.dart';

class DiscoverCard extends StatelessWidget {
  final SocialFeed socialFeed;
  final bool isLiked;
  final Animation<double>? animation;
  final VoidCallback onDoubleTap;
  final VoidCallback onPressedDetails;

  const DiscoverCard({
    Key? key,
    required this.socialFeed,
    required this.isLiked,
    this.animation,
    required this.onDoubleTap,
    required this.onPressedDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onPressedDetails,
              child: Text(
                socialFeed.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: onDoubleTap,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(
                    socialFeed.photoURL,
                    fit: BoxFit.cover,
                  ),
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
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null,
                    ),
                    onPressed: onDoubleTap,
                  ),
                  Text('Likes: ${socialFeed.likes}'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  children: [
                    Text(socialFeed.name),
                    Text(socialFeed.description),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
