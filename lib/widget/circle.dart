import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  bool _isAnimationCompleted = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimationCompleted = true;
        });
      }
    })
    ..forward();

    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isAnimationCompleted
    ? Container()
    : ScaleTransition(
        scale: _curvedAnimation,
        child: Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        foregroundPainter: _CirclePainter(Colors.blue),
      ),
    ));
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.dispose();
      _animationController = null;
    }
    super.dispose();
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
