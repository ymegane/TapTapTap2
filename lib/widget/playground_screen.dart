import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/circles_bloc_provider.dart';
import 'package:taptaptap2/widget/circles.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CirclesBlocProvider(
      child: Center(
        child: Circles(),
      ),
    );
  }
}
