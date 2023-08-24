import 'dart:convert';

import 'package:flutter/services.dart';

class TypicalFood {
  final String id;
  final String name;
  final String image;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> restaurants;

  TypicalFood({
    required this.id,
    required this.name,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.restaurants,
  });

  factory TypicalFood.fromJson(Map<String, dynamic> json) {
    final restaurantsList =
        (json['restaurants'] as List?)?.cast<String>() ?? [];

    return TypicalFood(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      restaurants: restaurantsList,
    );
  }
}

// Fetch a list from a json file in the asset folder
Future<List<TypicalFood>> fetchTypicalFoods() async {
  final response =
      await rootBundle.loadString('assets/data/typical_foods.json');
  final data = await json.decode(response);
  return data.map<TypicalFood>((json) => TypicalFood.fromJson(json)).toList();
}
