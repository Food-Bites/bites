import 'package:bites/utils/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // show a placeholder page where settings will go
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      // add a switch to toggle dark mode
      body: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: Provider.of<ThemeProvider>(context).themeType ==
                  ThemeType.dark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeType(value ? ThemeType.dark : ThemeType.light);
              },
            ),
          ),
        ],
      ),
    );
  }
}
