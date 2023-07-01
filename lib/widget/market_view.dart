import 'package:bites/data/buyable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/screens/buyable_food_details_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/widget/market_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  void _onLongPress(BuyableFood food, BuildContext context) {
    Provider.of<Cart>(context, listen: false).add(food);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${food.name} added to cart"),
        // material 3 style
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 1),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _navigateToDetailsPage(BuyableFood food, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BuyableFoodDetailsPage(foodItem: food),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build a 2 column grid of food items, on tap show a new Material page route with the food item details, on long press add food item to cart (use a provider)
    // return GridView.count(
    //   crossAxisCount: 2,
    //   children: buyableFoods.keys.map((key) {
    //     final food = BuyableFood.fromJson(buyableFoods[key]);
    //     return GestureDetector(
    //       onTap: () => _navigateToDetailsPage(food, context),
    //       onLongPress: () => _onLongPress(food, context),
    //       child: MarketCard(food: food),
    //     );
    //   }).toList(),
    // );
    return StaggeredGrid.count(
      crossAxisCount: isTablet(context) ? 4 : 2,
      children: buyableFoods.keys.map((key) {
        final food = BuyableFood.fromJson(buyableFoods[key]);
        return GestureDetector(
          onTap: () => _navigateToDetailsPage(food, context),
          onLongPress: () => _onLongPress(food, context),
          child: MarketCard(food: food),
        );
      }).toList(),
    );
  }
}
