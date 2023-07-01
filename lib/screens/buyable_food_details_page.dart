import 'package:bites/data/buyable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyableFoodDetailsPage extends StatelessWidget {
  final BuyableFood foodItem;

  const BuyableFoodDetailsPage({Key? key, required this.foodItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.name),
      ),
      body: Column(
        children: [
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
          Text(foodItem.name),
          Text(foodItem.price.toString()),
          // add a button that adds the food item to the cart
          ElevatedButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).add(foodItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${foodItem.name} added to cart"),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}
