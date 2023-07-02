import 'dart:convert';
import 'package:bites/data/social.dart';
import 'package:flutter/services.dart' show rootBundle;

/// The [DataService] class is a service that provides data to the app.
/// {@category Utils}
class DataService {
  Future<List<SocialFeed>> getRestaurants() async {
    final jsonString =
        await rootBundle.loadString('assets/data/restaurants.json');
    final jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList.map((json) => SocialFeed.fromJson(json)).toList();
  }
}
