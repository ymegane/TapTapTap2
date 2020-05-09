import 'package:flutter/material.dart';
import 'package:taptaptap2/widget/launch_screen.dart';
import 'package:taptaptap2/widget/playground_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapTapTap',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => LaunchScreen(),
        '/playground': (_) => PlaygroundScreen(),
      },
    );
  }
}
