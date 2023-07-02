import 'dart:math';

import 'package:flutter/material.dart';

/// The [isTablet] function returns true if the current viewport width is greater than or equal to 1024.
/// {@category Utils}
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1024;

/// The [toRad] function converts degrees to radians.
/// {@category Utils}
double toRad(double deg) => deg * pi / 180.0;
