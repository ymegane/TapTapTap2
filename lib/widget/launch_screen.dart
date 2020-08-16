import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatelessWidget {
  final TextStyle _titleStyle =
      GoogleFonts.luckiestGuy(fontSize: 48, fontWeight: FontWeight.w400);
  final TextStyle _messageStyle = GoogleFonts.notoSans(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                  SelectableText(
                    'TapTapTap',
                    textAlign: TextAlign.center,
                    style: _titleStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  SelectableText(
                    'A toy app for my children',
                    textAlign: TextAlign.center,
                    style: _messageStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(48),
                  ),
                  SizedBox(
                    width: 240,
                    child: RaisedButton(
                      color: theme.accentColor,
                      textColor: theme.accentTextTheme.button.color,
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
                child: SelectableText(
                  'Copyright 2020 @y_megane',
                  textAlign: TextAlign.center,
                  style: _messageStyle,
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
