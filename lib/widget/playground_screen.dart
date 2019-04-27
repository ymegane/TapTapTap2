import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/shapes_bloc_provider.dart';
import 'package:taptaptap2/widget/playground.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CirclesBlocProvider(
      child: Stack(
        children: <Widget>[
          Center(
            child: Playground(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: 48,
                child: RaisedButton(
                  color: Colors.white,
                  child: const Icon(Icons.close),
                  shape: CircleBorder(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
