import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/circles_bloc.dart';

class Circle extends StatefulWidget {
  static const CIRCLE_SIZE = 150.0;

  const Circle(
      {@required Key key,
      @required this.x,
      @required this.y,
      @required this.bloc})
      : super(key: key);
  final double x;
  final double y;
  final CirclesBloc bloc;

  @override
  State<StatefulWidget> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  final _rondomColor = _RandomColor().get();

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      value: 1.0,
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          print(status);
          widget.bloc.circleDeletion.add(widget);
        }
      })
      ..reverse();
    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.x,
      top: widget.y,
      child: FadeTransition(
        opacity: _curvedAnimation,
        alwaysIncludeSemantics: true,
        child: SizedBox(
          width: Circle.CIRCLE_SIZE,
          height: Circle.CIRCLE_SIZE,
          child: CustomPaint(
            foregroundPainter: _CirclePainter(_rondomColor),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}

class _RandomColor {
  final colors = Colors.primaries;

  Color get() {
    return colors[Random.secure().nextInt(colors.length)].withAlpha(200);
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
