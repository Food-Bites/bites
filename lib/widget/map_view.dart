import 'package:bites/screens/options_page.dart';
import 'package:bites/utils/food_details_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/utils/location.dart';
import 'package:bites/widget/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:bites/data/italian_cities.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  // write an object to represent latitude and longitude of milan
  final LatLng _milanCoordinates = const LatLng(45.4642, 9.1900);

  // getCities
  List<ItalianCities> cities = [];
  List<ItalianCities> filteredCities = [];

  late GoogleMapController mapController;
  late TextEditingController latitudeController, longitudeController;

  late GeoFlutterFire geo;
  Map<CircleId, Circle> circles = <CircleId, Circle>{};
  final Set<CircleId> selectedCircles = {};

// when initializing the widget
  @override
  void initState() {
    super.initState();
    latitudeController = TextEditingController();
    longitudeController = TextEditingController();
  }

  // When destroying the widget
  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      moveToCurrentLocation();
      updateCircles();
    });
  }

  void moveToCurrentLocation() async {
    var userPosition = await determinePosition();

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 12,
        ),
      ),
    );
  }

  void addCircle(double lat, double lng, Food food) {
    final id = CircleId(lat.toString() + lng.toString());
    final circle = Circle(
        circleId: id,
        center: LatLng(lat, lng),
        radius: 3 * 1000, // 15 kms
        strokeWidth: 2,
        strokeColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
        consumeTapEvents: true,
        onTap: () {
          onCircleTap(id);
        });
    setState(() {
      circles[id] = circle;
    });
  }

  void updateCircles() {
    typicalFoods.forEach((key, value) {
      final point = LatLng(value['latitude'], value['longitude']);
      addCircle(
          point.latitude,
          point.longitude,
          Food(
            name: value['name'],
            image: value['image'],
            city: value['city'],
            distance: value['distance'],
          ));
    });
  }

  void onCircleTap(CircleId circleId) {
    setState(() {
      if (selectedCircles.contains(circleId)) {
        selectedCircles.remove(circleId);
      } else {
        selectedCircles.clear();
        selectedCircles.add(circleId);
      }
    });
  }

  void onSearch(String query) {
    setState(() {
      filteredCities = cities
          .where(
              (city) => city.city.toLowerCase().contains(query.toLowerCase()))
          .take(3)
          .toList();
      if (query.isEmpty) {
        setState(() {
          filteredCities = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !isTablet(context)
          ? FloatingActionButton(
              onPressed: moveToCurrentLocation,
              child: const Icon(Icons.my_location),
            )
          : null,
      // bottomSheet: const DraggableBottomSheet(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            minMaxZoomPreference: const MinMaxZoomPreference(8, 12),
            initialCameraPosition: CameraPosition(
              target: _milanCoordinates,
              zoom: 8,
            ),
            zoomControlsEnabled: false,
            circles: Set<Circle>.of(circles.values),
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
                    hintText: 'Search for a location',
                    trailing: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                    ],
                    leading: IconButton(
                      onPressed: () {
                        // push the options page
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
                // show the list of filtered cities only if the user has typed something
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
                              return Card(
                                child: ListTile(
                                  title: Text(filteredCities[index].city),
                                  subtitle: Text(
                                      '${filteredCities[index].lat}, ${filteredCities[index].lng}'),
                                  trailing: const Icon(Icons.arrow_forward),
                                  onTap: () {
                                    mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            double.parse(filteredCities[index]
                                                .lat
                                                .toString()),
                                            double.parse(filteredCities[index]
                                                .lng
                                                .toString()),
                                          ),
                                          zoom: 12,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      filteredCities = [];
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        //TODO Clear query button may be unnecessary
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       filteredCities = [];
                        //     });
                        //   },
                        //   child: const Text('Clear'),
                        // )
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
