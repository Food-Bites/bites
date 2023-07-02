import 'package:bites/widget/location_text.dart';
import 'package:flutter/material.dart';

/// The [LocationHeaderDelegate] class is a utility widget to handle the scrolling of [Locationtext] and other elements on the page.
/// {@category Widgets}
class LocationHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const LocationText();
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
