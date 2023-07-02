import 'package:bites/widget/location_text.dart';
import 'package:flutter/material.dart';

/// The [LocationHeaderDelegate] class is a utility widget to handle the scrolling of [LocationText] and other elements on the page.
/// {@category Widgets}
class LocationHeaderDelegate extends SliverPersistentHeaderDelegate {
  double _headerHeight = 200.0; // set a default height

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // update the header height based on the height of the Column
        _headerHeight = constraints.maxHeight;
        return const LocationText();
      },
    );
  }

  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => _headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
