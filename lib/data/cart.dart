import 'package:bites/data/purchasable_foods.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // ready to accept multiple items
  final List<BuyableFood> _items = [];

  List<BuyableFood> get items => _items;

  void add(BuyableFood foodItem, BuildContext context) {
    if (_items.contains(foodItem) || _items.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You can only order one item at a time",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 5),
          showCloseIcon: true,
          closeIconColor: Theme.of(context).colorScheme.onErrorContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }
    _items.add(foodItem);
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
    notifyListeners();
  }

  void remove(BuyableFood foodItem) {
    _items.remove(foodItem);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool contains(BuyableFood foodItem) {
    return _items.contains(foodItem);
  }

  int get count => _items.length;
}
