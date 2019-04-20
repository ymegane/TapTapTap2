import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TapTapTap',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    'A toy app for my children',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(48),
                  ),
                  SizedBox(
                    width: 240,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
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
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Copyright 2019 @y_megane',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _handleStartClick(BuildContext context) {
  Navigator.pushReplacementNamed(context, 'playground');
}
