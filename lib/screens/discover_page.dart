import 'package:flutter/material.dart';
import 'package:bites/widget/discover_view.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  //TODO: Add Stories and intents to maps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: const DiscoverView(),
    );
  }
}
