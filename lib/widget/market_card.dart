import 'package:bites/data/purchasable_foods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  const MarketCard({super.key, required this.food});
  final PurchasableFood food;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: food.id,
        child: CachedNetworkImage(
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
