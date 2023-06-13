import 'dart:convert';
import 'package:flutter/services.dart';

class ItalianCities {
  String city;
  String lat;
  String lng;

  ItalianCities({
    required this.city,
    required this.lat,
    required this.lng,
  });

  factory ItalianCities.fromJson(Map<String, dynamic> json) {
    return ItalianCities(
      city: json['city'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

// load the json file into a map

Future<List<ItalianCities>> getCities() async {
  final jsonData =
      await rootBundle.loadString('assets/data/italian_cities.json');
  final data = json.decode(jsonData);
  List<ItalianCities> cities = [];
  for (var i = 0; i < data.length; i++) {
    cities.add(ItalianCities(
      city: data[i]['city'],
      lat: data[i]['lat'],
      lng: data[i]['lng'],
    ));
  }
  return cities;
}
