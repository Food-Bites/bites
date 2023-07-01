import 'package:bites/data/purchasable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/screens/purchasable_food_details_page.dart';
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
        builder: (context) => PurchasableFoodDetailsPage(foodItem: food),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: isTablet(context) ? 4 : 2,
      children: purchasableFood.keys.map((key) {
        final food = BuyableFood.fromJson(purchasableFood[key]);
        return GestureDetector(
          onTap: () => _navigateToDetailsPage(food, context),
          onLongPress: () => _onLongPress(food, context),
          child: MarketCard(food: food),
        );
      }).toList(),
    );
  }
}
