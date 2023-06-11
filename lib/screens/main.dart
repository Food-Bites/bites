import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  // TODO remove this function
  void _clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    // add a button to cleare the shared preferences
    return Scaffold(
      // TODO insert the tabs layout
      body: Center(
        child: ElevatedButton(
            onPressed: _clearPreferences, child: const Text("Clear")),
      ),
    );
  }
}
