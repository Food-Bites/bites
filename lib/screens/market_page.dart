import 'package:bites/data/cart.dart';
import 'package:bites/screens/cart_page.dart';
import 'package:bites/widget/helper_text.dart';
import 'package:bites/widget/location_header.dart';
import 'package:bites/widget/market_view.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Badge(
        label: Text(
          Provider.of<Cart>(context).items.length.toString(),
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
              delegate: LocationHeaderDelegate(),
              floating: false,
            ),
          ];
        },
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HelperText(
                text: "Tap to know more, hold to add to cart",
                icon: IconType.heroIcons(HeroIcons.informationCircle),
              ),
            ),
            const MarketView(),
          ],
        ),
      ),
    );
  }
}
