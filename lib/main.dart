import 'package:bites/data/cart.dart';
import 'package:bites/screens/initial_page.dart';
import 'package:bites/utils/color_scheme.dart';
import 'package:bites/utils/suggestions_switch.dart';
import 'package:bites/utils/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

/// The MainApp class is the root widget of the app. It is a stateless widget. It is wrapped in a MultiProvider widget which provides the app with the following providers:
/// 1. ThemeProvider: This provider provides the app with the theme mode of the app. It is used to switch between light and dark mode.
/// 2. SuggestionTipsProvider: This provider provides the app with the state of the suggestion tips switch. It is used to switch between showing and hiding the suggestion tips.
/// 3. Cart: This provider provides the app with the state of the cart. It is used to store the items in the cart.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SuggestionTipsProvider()),
        ChangeNotifierProvider(create: (context) => Cart())
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          home: const InitialPage(),
        );
      },
    );
  }
}
