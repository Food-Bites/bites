import 'package:bites/data/purchasable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/data/screens/purchasable_food_details_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/widget/market_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

/// The [MarketView] class is the view that displays a [StaggeredGrid] of purchasable products.
/// {@category Widgets}
class MarketView extends StatelessWidget {
  const MarketView({super.key});

  void _onLongPress(PurchasableFood food, BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).add(food, context);
  }

  void _navigateToDetailsPage(PurchasableFood food, BuildContext context) {
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
        final food = PurchasableFood.fromJson(purchasableFood[key]);
        return GestureDetector(
          onTap: () => _navigateToDetailsPage(food, context),
          onLongPress: () => _onLongPress(food, context),
          child: MarketCard(food: food),
        );
      }).toList(),
    );
  }
}
