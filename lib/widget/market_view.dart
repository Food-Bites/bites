import 'package:bites/data/buyable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/screens/buyable_food_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    // build a 2 column grid of food items, on tap show a new Material page route with the food item details, on long press add food item to cart (use a provider)
    return GridView.count(
      crossAxisCount: 2,
      children: buyableFoods.keys.map((key) {
        final food = BuyableFood.fromJson(buyableFoods[key]);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BuyableFoodDetailsPage(foodItem: food),
              ),
            );
          },
          onLongPress: () {
            Provider.of<Cart>(context, listen: false).add(food);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${food.name} added to cart"),
                // material 3 style
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Hero(
              tag: food.id,
              child: CachedNetworkImage(
                useOldImageOnUrlChange: true,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: food.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
