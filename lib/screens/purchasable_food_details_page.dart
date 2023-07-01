import 'package:bites/data/purchasable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class PurchasableFoodDetailsPage extends StatelessWidget {
  final BuyableFood foodItem;

  const PurchasableFoodDetailsPage({Key? key, required this.foodItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodItem.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              Hero(
                tag: foodItem.id,
                child: CachedNetworkImage(
                  useOldImageOnUrlChange: true,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/error.png',
                    fit: BoxFit.cover,
                  ),
                  imageUrl: foodItem.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                foodItem.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              // add a badge that shows the price
              Chip(
                avatar: const HeroIcon(HeroIcons.currencyEuro),
                label: Text(
                  "${foodItem.price}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
              // add a button that adds the food item to the cart
              Text(
                "Where to buy:",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                foodItem.owner,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Add to Cart"),
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).add(foodItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${foodItem.name} added to cart"),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
