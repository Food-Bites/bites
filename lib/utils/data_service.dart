import 'dart:convert';
import 'package:bites/data/social.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  Future<List<SocialFeed>> getRestaurants() async {
    final jsonString = await rootBundle.loadString('assets/data/restaurant.json');
    final jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList.map((json) => SocialFeed.fromJson(json)).toList();
  }
}
