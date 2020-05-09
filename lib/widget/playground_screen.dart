import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/shapes_bloc_provider.dart';
import 'package:taptaptap2/widget/playground.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CirclesBlocProvider(
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Playground(),
          ),
          SafeArea(
            child: _buildCloseButton(context),
          )
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 48,
        child: RaisedButton(
          color: theme.primaryColor,
          child: Icon(Icons.close, color: theme.primaryTextTheme.button.color),
          shape: const CircleBorder(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
