import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: const <Widget>[
                Text(
                  'TapTapTap',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Text(
                  'A toy app for my children',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 240,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    textColor: Colors.white,
                    child: const Text(
                      'Start',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => _handleStartClick(context),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                const Text(
                  'Copyright 2019 y_megane',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _handleStartClick(BuildContext context) {
  Navigator.pushReplacementNamed(context, 'playground');
}
