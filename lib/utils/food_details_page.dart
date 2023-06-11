// build a food details page

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key, required this.food});

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
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: food.image ?? '',
                            fit: BoxFit.cover,
                          ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      food.name,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    if (food.distance != null)
                      Text(
                        '${food.distance!.toStringAsFixed(1)} km',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    if (food.city != null)
                      Text(
                        food.city!,
                        style: Theme.of(context).textTheme.subtitle2,
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
