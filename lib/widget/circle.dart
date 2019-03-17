import 'dart:ui';
import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  bool animationCompleted = false;

  @override
  void initState() {

    Timer(const Duration(seconds: 1), (){
      setState(() {
        animationCompleted = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: animationCompleted ? 0 : 1,
            curve: Curves.easeInOut,
            child: SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                foregroundPainter: _CirclePainter(Colors.blue),
              ),
            ))
      ],
    ) ;
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
