import 'package:bites/data/typical_foods.dart';
import 'package:bites/screens/typical_food_details_page.dart';
import 'package:bites/widget/location_text.dart';
import 'package:bites/widget/magic_image.dart';
import 'package:flutter/material.dart';

/// The [FoodBottomSheet] class is the widget displayed when the user
/// taps on a circle. It contains a list of typical foods of that city.
/// {@category Widgets}
class FoodBottomSheet extends StatelessWidget {
  const FoodBottomSheet({
    Key? key,
    required this.lat,
    required this.lng,
    required this.foods,
  }) : super(key: key);

  final double lat;
  final double lng;
  final List<TypicalFood> foods;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // handle of the bottom sheet
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 32,
                margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: LocationText(
              text: "Typical foods in",
              isSmall: true,
              hasCustomCity: true,
              lat: lat,
              lng: lng,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: foods.map((food) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TypicalFoodDetailsPage(
                            food: food,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 0,
                      child: SizedBox(
                        width: 128,
                        child: Stack(
                          children: [
                            MagicImage(
                              food: food,
                              width: 128,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  food.name,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
