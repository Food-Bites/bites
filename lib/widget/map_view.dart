import 'package:bites/screens/options_page.dart';
import 'package:bites/screens/typical_food_details_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:bites/utils/location.dart';
import 'package:bites/widget/place_card.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bites/data/typical_foods.dart';
import 'package:bites/data/italian_cities.dart';

/// The [MapView] class is the page that displays the map.
/// {@category Widgets}
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

  /// The [onMapCreated] function is called when the map is created.
  /// It sets the [mapController] and moves the camera to the current location.
  /// It also updates the circles on the map.
  /// @param controller The [GoogleMapController] object.
  /// {@category Functions}
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      moveToCurrentLocation();
      updateCircles();
    });
  }

  /// The [moveToCurrentLocation] function moves the camera to the current location of the user.
  /// It uses the [determinePosition] function from the [location.dart] file.
  /// {@category Functions}
  void moveToCurrentLocation() async {
    BuildContext context = this.context;
    var userPosition = await determinePosition(context);

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 12,
        ),
      ),
    );
  }

  /// The [addCircle] function adds a circle to the map.
  /// @param lat The latitude of the circle.
  /// @param lng The longitude of the circle.
  /// @param food The [TypicalFood] object.
  /// {@category Functions}
  void addCircle(double lat, double lng, TypicalFood food) {
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TypicalFoodDetailsPage(food: food),
            ),
          );
        });
    setState(() {
      circles[id] = circle;
    });
  }

  /// The [updateCircles] function updates the circles on the map.
  /// It uses the [typicalFoods] map from the [typical_foods.dart] file.
  /// {@category Functions}
  void updateCircles() {
    typicalFoods.forEach((key, value) {
      final point = LatLng(value['latitude'], value['longitude']);
      addCircle(
        point.latitude,
        point.longitude,
        TypicalFood(
          id: value['id'],
          name: value['name'],
          image: value['image'],
          latitude: value['latitude'],
          longitude: value['longitude'],
          description: value['description'],
        ),
      );
    });
  }

  /// The [onSearch] function is called when the user types something in the search bar.
  /// It filters the cities based on the query.
  /// @param query The query string.
  /// {@category Functions}
  void onSearch(String query) {
    setState(() {
      filteredCities = cities
          .where(
              (city) => city.city.toLowerCase().contains(query.toLowerCase()))
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

  /// The [moveCameraTo] function moves the camera to the location of the city.
  /// @param index The index of the city in the [filteredCities] list.
  /// {@category Functions}
  void moveCameraTo(int index) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            double.parse(filteredCities[index].lat.toString()),
            double.parse(filteredCities[index].lng.toString()),
          ),
          zoom: 12,
        ),
      ),
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
      // NOT AVAILABLE FOR NOW
      // bottomSheet: const DraggableBottomSheet(),
      body: Stack(
        alignment: Alignment.topCenter,
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
