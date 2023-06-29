import 'package:bites/screens/discover_page.dart';
import 'package:bites/screens/map_page.dart';
import 'package:bites/screens/market_page.dart';
import 'package:bites/utils/functions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  bool _isConnected = true;

  final List<Widget> _pages = const [
    MapPage(),
    DiscoverPage(),
    MarketPage(),
  ];

  final PageController _pageController = PageController(initialPage: 0);

  void onTabTapped(int index) {
    final int lastIndex = _currentIndex;
    setState(() {
      _currentIndex = index;
    });

    final int delta = index - lastIndex;

    if (delta.abs() > 1) {
      // If the new index is more than 1 page away from the current index,
      // animate the PageView to the intermediate page(s) first
      _pageController.animateToPage(
        lastIndex + delta ~/ delta.abs(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    // Animate the PageView to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // if (_isConnected == false) {
    //   return Scaffold(
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Icon(
    //             Icons.wifi_off,
    //             size: 64,
    //           ),
    //           const SizedBox(height: 16),
    //           const Text(
    //             "No internet connection",
    //             style: TextStyle(
    //               fontSize: 24,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           const Text(
    //             "Please check your internet connection and try again",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           ElevatedButton(
    //             onPressed: () {
    //               initConnectivity();
    //             },
    //             child: const Text("Retry"),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      bottomSheet: !_isConnected
          ? BottomSheet(
              onClosing: () {
                setState(() {
                  _isConnected = true;
                });
              },
              builder: (context) => Container(
                height: 32,
                color: Theme.of(context).colorScheme.errorContainer,
                child: const Center(
                  child: Text("No internet connection"),
                ),
              ),
            )
          : null,
      body: Row(
        children: [
          if (isTablet(context))
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "NAVIGATION_RAIL_LOCATION_BUTTON",
                    onPressed: () {},
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.map),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  label: Text('Discover'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Profile'),
                ),
              ],
              selectedIndex: _currentIndex,
              onDestinationSelected: onTabTapped,
            ),
          Expanded(
            // add some border radius to the pageview
            child: ClipRRect(
              borderRadius: isTablet(context)
                  ? const BorderRadius.all(
                      Radius.circular(16),
                    )
                  : const BorderRadius.all(
                      Radius.zero,
                    ),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _pages,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: !isTablet(context)
          ? NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: onTabTapped,
              destinations: const [
                NavigationDestination(
                  icon: HeroIcon(
                    HeroIcons.map,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: HeroIcon(HeroIcons.globeEuropeAfrica),
                  label: 'Discover',
                ),
                NavigationDestination(
                  icon: HeroIcon(HeroIcons.buildingStorefront),
                  label: 'Profile',
                ),
              ],
            )
          : null,
    );
  }
}
