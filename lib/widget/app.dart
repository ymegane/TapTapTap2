import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/circles_bloc_provider.dart';
import 'package:taptaptap2/widget/circles.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapTapTap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CirclesBlocProvider(
        child: Center(
          child: Circles(),
        ),
      ),
    );
  }
}
