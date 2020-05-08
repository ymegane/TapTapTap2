import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    style: GoogleFonts.luckiestGuy(
                        fontSize: 48, fontWeight: FontWeight.w400),
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
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
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
