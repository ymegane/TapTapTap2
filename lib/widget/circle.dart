import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/circles_bloc.dart';

class Circle extends StatefulWidget {
  const Circle(
      {@required Key key,
      @required this.x,
      @required this.y,
      @required this.bloc})
      : super(key: key);

  final double x;
  final double y;
  final CirclesBloc bloc;

  static const double CIRCLE_SIZE = 300.0;

  @override
  State<StatefulWidget> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  AnimationController _fadeAnimationController;
  AnimationController _scaleAnimationController;
  CurvedAnimation _fadeAnimation;
  CurvedAnimation _scaleAnimation;

  final Color _randomColor = _RandomColor().get();

  @override
  void initState() {
    _scaleAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    _fadeAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          //print(status);
          widget.bloc.circleDeletion.add(widget);
        }
      })
      ..reverse();
    _fadeAnimation = CurvedAnimation(
        parent: _fadeAnimationController, curve: Curves.fastLinearToSlowEaseIn);
    _scaleAnimation = CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.fastLinearToSlowEaseIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.x,
      top: widget.y,
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          alwaysIncludeSemantics: true,
          child: SizedBox(
            width: Circle.CIRCLE_SIZE,
            height: Circle.CIRCLE_SIZE,
            child: CustomPaint(
              foregroundPainter: _CirclePainter(_randomColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }
}

class _RandomColor {
  final List<Color> colors = Colors.primaries;

  Color get() {
    return colors[Random.secure().nextInt(colors.length)].withAlpha(200);
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(this.circleColor);

  Color circleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circle = Paint()..color = circleColor;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
