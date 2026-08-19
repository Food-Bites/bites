import 'package:bites/data/screens/options_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/utils/location.dart';
import 'package:bites/widget/place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:bites/data/italian_cities.dart';
import 'package:bites/widget/food_bottom_sheet.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final LatLng _milanCoordinates = const LatLng(45.4642, 9.1900);

  List<ItalianCities> cities = [];
  List<ItalianCities> filteredCities = [];

  late MapController mapController;
  late TextEditingController latitudeController, longitudeController;

  final List<CircleMarker> _circles = [];
  final Map<String, List<TypicalFood>> _foodsByLocation = {};

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    latitudeController = TextEditingController();
    longitudeController = TextEditingController();
    _loadCircles();
  }

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    mapController.dispose();
    super.dispose();
  }

  void onMapCreated() {
    moveToCurrentLocation();
  }

  void moveToCurrentLocation() async {
    BuildContext context = this.context;
    var userPosition = await determinePosition(context);

    mapController.move(
      LatLng(userPosition.latitude, userPosition.longitude),
      12,
    );
  }

  void addCircle(double lat, double lng, List<TypicalFood> foods) {
    final locationKey = "$lat-$lng";
    _foodsByLocation[locationKey] = foods;

    final circle = CircleMarker(
      point: LatLng(lat, lng),
      radius: 3000,
      useRadiusInMeter: true,
      borderStrokeWidth: 2,
      color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
      borderColor: Theme.of(context).primaryColor,
    );
    setState(() {
      _circles.add(circle);
    });
  }

  Future<void> _loadCircles() async {
    List<TypicalFood> foods = await fetchTypicalFoods();

    Map<String, dynamic> foodsByLocation = {};

    for (var food in foods) {
      String location = "${food.latitude}-${food.longitude}";
      if (foodsByLocation.containsKey(location)) {
        foodsByLocation[location].add(food);
      } else {
        foodsByLocation[location] = [food];
      }
    }

    foodsByLocation.forEach((key, value) {
      List<String> coordinates = key.split('-');
      double lat = double.parse(coordinates[0]);
      double lng = double.parse(coordinates[1]);
      addCircle(lat, lng, value);
    });
  }

  void _onMapTap(LatLng point) {
    const distanceCalc = Distance();
    for (final entry in _foodsByLocation.entries) {
      final coords = entry.key.split('-');
      final lat = double.parse(coords[0]);
      final lng = double.parse(coords[1]);
      final center = LatLng(lat, lng);
      final distance = distanceCalc(point, center);
      if (distance <= 3000) {
        Scaffold.of(context).showBottomSheet(
          (context) => FoodBottomSheet(
            lat: lat,
            lng: lng,
            foods: entry.value,
          ),
          enableDrag: true,
        );
        return;
      }
    }
  }

  void onSearch(String query) {
    setState(() {
      filteredCities = cities
          .where((city) => city.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredCities.sort((a, b) => a.city.length.compareTo(b.city.length));
      filteredCities = filteredCities.take(3).toList();
      if (query.isEmpty) {
        setState(() {
          filteredCities = [];
        });
      }
    });
  }

  void moveCameraTo(int index) {
    mapController.move(
      LatLng(
        double.parse(filteredCities[index].lat.toString()),
        double.parse(filteredCities[index].lng.toString()),
      ),
      12,
    );
    setState(() {
      filteredCities = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !isTablet(context),
        child: FloatingActionButton(
          onPressed: moveToCurrentLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (tapPosition, point) => _onMapTap(point),
              onMapReady: onMapCreated,
              initialCenter: _milanCoordinates,
              initialZoom: 8,
              minZoom: 8,
              maxZoom: 12,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.bites.bites',
              ),
              CircleLayer(
                circles: _circles,
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    onChanged: (q) {
                      onSearch(q);
                    },
                    onTap: () async {
                      cities = await getCities();
                    },
                    hintText: 'Search a place',
                    trailing: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                    ],
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const OptionsPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ),
                if (filteredCities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 256,
                          child: ListView.builder(
                            itemCount: filteredCities.length,
                            itemBuilder: (context, index) {
                              return PlaceCard(
                                city: filteredCities[index].city,
                                latitude: double.parse(
                                    filteredCities[index].lat.toString()),
                                longitude: double.parse(
                                    filteredCities[index].lng.toString()),
                                onTap: () {
                                  moveCameraTo(index);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
