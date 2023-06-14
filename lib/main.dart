import 'package:bites/screens/initial_page.dart';
import 'package:bites/utils/color_scheme.dart';
import 'package:bites/utils/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final apiKey = dotenv.env['API_KEY'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        themeProvider.loadThemeMode();
        return MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: themeProvider.themeMode,
          home: const InitialPage(),
        );
      },
    );
  }
}
