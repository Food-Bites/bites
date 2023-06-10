import 'package:bites/utils/location.dart';
import 'package:bites/widget/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bites/utils/foods.dart';
import 'package:bites/utils/italian_cities.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  // write an object to represent latitude and longitude of milan
  final LatLng _milanCoordinates = const LatLng(45.4642, 9.1900);

  // getCities
  List<ItalianCities> _cities = [];
  List<ItalianCities> _filteredCities = [];

  late GoogleMapController _mapController;
  late TextEditingController _latitudeController, _longitudeController;

  // firestore init
  // final _firestore = FirebaseFirestore.instance;
  late GeoFlutterFire geo;
  // late Stream<List<DocumentSnapshot>> stream;
  Map<CircleId, Circle> circles = <CircleId, Circle>{};

// when initializing the widget
  @override
  void initState() {
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
  }

  // When destroying the widget
  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _showCurrentLocation();
      updateCircles();
    });
  }

  void _showCurrentLocation() async {
    // get current location of the user, if not available, use milan coordinates
    var userPosition = await determinePosition();

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 12,
        ),
      ),
    );
  }

  void _addCircle(double lat, double lng) {
    final id = CircleId(lat.toString() + lng.toString());
    final circle = Circle(
      circleId: id,
      center: LatLng(lat, lng),
      radius: 3 * 1000, // 15 kms
      strokeWidth: 2,
      strokeColor: Theme.of(context).primaryColor,
      fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
      onTap: () {},
    );
    setState(() {
      circles[id] = circle;
    });
  }

  void updateCircles() {
    foods.forEach((key, value) {
      final point = LatLng(value['latitude'], value['longitude']);
      _addCircle(point.latitude, point.longitude);
    });
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) _filteredCities = [];
      _filteredCities = _cities
          .where(
              (city) => city.city.toLowerCase().contains(query.toLowerCase()))
          .take(3)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
      bottomSheet: const DraggableBottomSheet(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            minMaxZoomPreference: const MinMaxZoomPreference(8, 12),
            initialCameraPosition: CameraPosition(
              target: _milanCoordinates,
              zoom: 8,
            ),
            zoomControlsEnabled: false,
            circles: Set<Circle>.of(circles.values),
            onTap: (e) {
              // clean up the search results
              setState(() {
                _filteredCities = [];
              });
            },
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    onChanged: (q) {
                      _onSearch(q);
                    },
                    onTap: () async {
                      _cities = await getCities();
                    },
                    hintText: 'Search for a location',
                    trailing: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                    ],
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ),
                // show the list of filtered cities only if the user has typed something
                if (_filteredCities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: SizedBox(
                      height: 256,
                      child: ListView.builder(
                        itemCount: _filteredCities.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_filteredCities[index].city),
                              subtitle: Text(
                                  '${_filteredCities[index].lat}, ${_filteredCities[index].lng}'),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                _mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        double.parse(_filteredCities[index]
                                            .lat
                                            .toString()),
                                        double.parse(_filteredCities[index]
                                            .lng
                                            .toString()),
                                      ),
                                      zoom: 12,
                                    ),
                                  ),
                                );
                                setState(() {
                                  _filteredCities = [];
                                });
                              },
                            ),
                          );
                        },
                      ),
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
