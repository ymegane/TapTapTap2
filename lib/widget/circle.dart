import 'dart:ui';
import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  static const CIRCLE_SIZE = 150.0;

  Circle({@required this.x, @required this.y});
  final double x;
  final double y;

  @override
  State<StatefulWidget> createState() => _CircleState(x, y);
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  _CircleState(this._x, this._y);
  final double _x;
  final double _y;

  bool animationCompleted = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        animationCompleted = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: animationCompleted ? 0 : 1,
            curve: Curves.easeInOut,
            child: SizedBox(
              width: Circle.CIRCLE_SIZE,
              height: Circle.CIRCLE_SIZE,
              child: CustomPaint(
                foregroundPainter: _CirclePainter(Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(this.circleColor);

  Color circleColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()..color = circleColor;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
