import 'package:android_intent/android_intent.dart';
import 'package:bites/data/purchasable_foods.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/widget/helper_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class PurchasableFoodDetailsPage extends StatelessWidget {
  final BuyableFood foodItem;

  const PurchasableFoodDetailsPage({Key? key, required this.foodItem})
      : super(key: key);

  void _intentToGoogleMaps(String place) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: 'geo:0,0?q=${place.replaceAll(" ", "+")}',
      package: 'com.google.android.apps.maps',
    );
    intent.launch();
  }

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
              const SizedBox(height: 16.00),
              isTablet(context)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: 256,
                            child: Hero(
                              tag: foodItem.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  width: 256,
                                  useOldImageOnUrlChange: true,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/error.png',
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: foodItem.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(flex: 6, child: Details(food: foodItem)),
                      ],
                    )
                  : Hero(
                      tag: foodItem.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          width: 256,
                          useOldImageOnUrlChange: true,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
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
                    ),
              isTablet(context)
                  ? const SizedBox.shrink()
                  : Details(food: foodItem),
              const SizedBox(height: 16),
              HelperText(
                icon: IconType.heroIcons(HeroIcons.informationCircle),
                text: 'Tap the address to open in Google Maps',
              ),
              Text(
                "Where to buy:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 16),
              Wrap(
                children: [
                  const HeroIcon(HeroIcons.mapPin),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _intentToGoogleMaps(foodItem.owner),
                    child: Text(
                      foodItem.owner,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
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

class Details extends StatelessWidget {
  const Details({super.key, required this.food});
  final BuyableFood food;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: isTablet(context)
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Chip(
              avatar: const HeroIcon(HeroIcons.currencyEuro),
              label: Text(
                "${food.price}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
