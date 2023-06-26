import 'package:bites/widget/location_text.dart';
import 'package:flutter/material.dart';

class LocationHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const LocationText();
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 200.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
