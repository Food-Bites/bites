import 'package:flutter/material.dart';

// get current viewport width and return true if it's a tablet
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1024;
