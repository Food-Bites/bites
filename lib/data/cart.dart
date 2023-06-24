import 'package:bites/data/buyable_foods.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<BuyableFood> _items = [];
  double _totalPrice = 0;

  List<BuyableFood> get items => _items;
  double get totalPrice => _totalPrice;

  void add(BuyableFood foodItem) {
    _items.add(foodItem);
    _totalPrice += foodItem.price;
    notifyListeners();
  }

  void remove(BuyableFood foodItem) {
    _items.remove(foodItem);
    _totalPrice -= foodItem.price;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  bool contains(BuyableFood foodItem) {
    return _items.contains(foodItem);
  }

  int get count => _items.length;
}
