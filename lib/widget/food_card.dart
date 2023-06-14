import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Food {
  const Food({
    required this.name,
    this.image,
    this.city,
    this.distance,
  });

  final String name;
  final String? image;
  final String? city;
  final double? distance;
}

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // display the food image and name
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (food.image != null)
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const Center(child: LinearProgressIndicator()),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(imageUrl: food.image ?? ''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      food.city ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${food.distance ?? ''} km',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
