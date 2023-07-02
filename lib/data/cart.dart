import 'package:bites/data/purchasable_foods.dart';
import 'package:flutter/material.dart';

/// A [CartProvider] class that represents a shopping cart for [PurchasableFood] items.
///
/// The [CartProvider] class is a [ChangeNotifier], which means that it can notify its listeners
/// when the contents of the cart are modified by calling [notifyListeners]. This can
/// be useful for updating the UI in response to changes to the cart.
///
/// The [CartProvider] class maintains a list of [PurchasableFood] items that have been added to the cart.
/// It provides methods for adding, removing, and clearing items from the cart, as well as checking
/// whether a particular item is already in the cart.
/// {@category Data}
class CartProvider extends ChangeNotifier {
  // ready to accept multiple items
  final List<PurchasableFood> _items = [];

  /// Returns a list of [PurchasableFood] items that have been added to the cart.
  List<PurchasableFood> get items => _items;

  /// Adds a [PurchasableFood] item to the cart.
  ///
  /// If the item is already in the cart or there is already an item in the cart, a
  /// [SnackBar] is displayed with an error message and the item is not added to the cart.
  ///
  /// If the item is successfully added to the cart, a [SnackBar] is displayed with a success message.
  ///
  /// The [BuildContext] is used to display the [SnackBar].
  void add(PurchasableFood foodItem, BuildContext context) {
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

  /// Removes a [PurchasableFood] item from the cart.
  void remove(PurchasableFood foodItem) {
    _items.remove(foodItem);
    notifyListeners();
  }

  /// Clears the cart of all [PurchasableFood] items.
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Returns true if the cart contains the specified [PurchasableFood] item, false otherwise.
  bool contains(PurchasableFood foodItem) {
    return _items.contains(foodItem);
  }

  /// Returns the number of [PurchasableFood] items in the cart.
  int get count => _items.length;
}
