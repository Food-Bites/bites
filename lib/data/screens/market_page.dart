import 'package:bites/data/cart.dart';
import 'package:bites/data/screens/cart_page.dart';
import 'package:bites/widget/helper_text.dart';
import 'package:bites/widget/location_header.dart';
import 'package:bites/widget/market_view.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

/// MarketPage is the page that displays the list of purchasable products.
/// {@category Screens}
class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Badge(
        label: Text(
          Provider.of<CartProvider>(context).items.length.toString(),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      body: NestedScrollView(
        clipBehavior: Clip.none,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate: LocationHeaderDelegate(text: "Buy in"),
              floating: false,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HelperText(
                  text: "Tap to view details, long press to add to cart",
                  icon: IconType.heroIcons(HeroIcons.informationCircle),
                ),
                const MarketView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
