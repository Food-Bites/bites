import 'dart:math';

import 'package:bites/utils/location.dart';
import 'package:bites/widget/food_card.dart';
import 'package:flutter/material.dart';
import 'package:bites/data/typical_foods.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({super.key});

  @override
  DraggableBottomSheetState createState() => DraggableBottomSheetState();
}

class DraggableBottomSheetState extends State<DraggableBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _sheetHeight = 100;
  final double _minSheetHeight = 100;
  late double _maxSheetHeight;

  // add a field to store the sorted foods
  Map<String, dynamic> sortedFoods = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          _sheetHeight =
              _animationController.value * (_maxSheetHeight - _minSheetHeight) +
                  _minSheetHeight;
        });
      });
    _sortFoodsByDistance();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // write a function that calculates the distance between my location and the food location
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    final a = 0.5 -
        cos((lat2 - lat1) * pi) / 2 +
        cos(lat1 * pi) * cos(lat2 * pi) * (1 - cos((lon2 - lon1) * pi)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // write a function to sort the foods by distance
  void _sortFoodsByDistance() async {
    // get current location of the user, if not available, use milan coordinates
    determinePosition().then((userPosition) {
      // sort the foods by distance
      typicalFoods.forEach((key, value) {
        final double distance = _calculateDistance(
          userPosition.latitude,
          userPosition.longitude,
          value['latitude'],
          value['longitude'],
        );
        typicalFoods[key]['distance'] = distance;
      });
      // sort the foods by distance
      typicalFoods = Map.fromEntries(
        typicalFoods.entries.toList()
          ..sort(
              (e1, e2) => e1.value['distance'].compareTo(e2.value['distance'])),
      );

      sortedFoods = typicalFoods;
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxSheetHeight = MediaQuery.of(context).size.height * 0.4;

    return GestureDetector(
      onVerticalDragStart: (details) {
        _animationController.stop();
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          _sheetHeight -= details.delta.dy;
          if (_sheetHeight < _minSheetHeight) {
            _sheetHeight = _minSheetHeight;
          } else if (_sheetHeight > _maxSheetHeight) {
            _sheetHeight = _maxSheetHeight;
          }
        });
      },
      onVerticalDragEnd: (details) {
        double snapToHeight;
        if (_sheetHeight <= (_minSheetHeight + _maxSheetHeight) / 2) {
          snapToHeight = _minSheetHeight;
        } else {
          snapToHeight = _maxSheetHeight;
        }
        _animationController.animateTo(
          (snapToHeight - _minSheetHeight) /
              (_maxSheetHeight - _minSheetHeight),
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 250),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: _sheetHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // drag handle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // title
            // if (_sheetHeight >= _minSheetHeight + kToolbarHeight)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Foods near you',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            // list of food cards
            if (_sheetHeight == _maxSheetHeight)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      sortedFoods.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FoodCard(
                          food: Food(
                            name: sortedFoods.values.elementAt(index)['name'],
                            image: sortedFoods.values.elementAt(index)['image'],
                            distance:
                                sortedFoods.values.elementAt(index)['distance'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
