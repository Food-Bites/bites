import 'package:bites/screens/discover_page.dart';
import 'package:bites/screens/map_page.dart';
import 'package:bites/screens/market_page.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // add a button to cleare the shared preferences
  int _currentIndex = 0;

  final List<Widget> _children = const [
    MapPage(),
    DiscoverPage(),
    MarketPage(),
  ];

  final PageController _pageController = PageController(initialPage: 0);

  // get current viewport width and return true if it's a tablet
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (isTablet(context))
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  FloatingActionButton(
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
                  label: Text('Search'),
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
                children: _children,
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
                  label: 'Search',
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
