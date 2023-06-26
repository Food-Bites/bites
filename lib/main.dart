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
