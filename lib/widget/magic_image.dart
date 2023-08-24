import 'package:bites/data/typical_foods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MagicImage extends StatelessWidget {
  const MagicImage({super.key, required this.food, this.width = 256});
  final TypicalFood food;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: food.id,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          width: width,
          useOldImageOnUrlChange: true,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/error.png',
            fit: BoxFit.cover,
          ),
          imageUrl: food.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
