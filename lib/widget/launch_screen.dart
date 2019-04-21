import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'TapTapTap',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'LuckiestGuy',
                      fontSize: 48.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  const Text(
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
                    child: CupertinoButton(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: const Text(
                  'Copyright 2019 @y_megane',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _handleStartClick(BuildContext context) {
  Navigator.pushNamed(context, '/playground');
}
