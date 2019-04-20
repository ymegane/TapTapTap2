import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taptaptap2/widget/launch_screen.dart';
import 'package:taptaptap2/widget/playground_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => LaunchScreen(),
        '/playground': (_) => PlaygroundScreen(),
      },
    );
  }
}
