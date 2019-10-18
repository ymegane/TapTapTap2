import 'package:flutter/material.dart';
import 'package:taptaptap2/widget/launch_screen.dart';
import 'package:taptaptap2/widget/playground_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: _getThemeData(context),
          child: child,
        );
      },
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => LaunchScreen(),
        '/playground': (_) => PlaygroundScreen(),
      },
    );
  }

  ThemeData _getThemeData(BuildContext context) {
    final bool darkMode = isDarkMode(context);
    return ThemeData(brightness: darkMode ? Brightness.dark : Brightness.light);
  }

  static bool isDarkMode(BuildContext context) {
    // for iOS13
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }
}
