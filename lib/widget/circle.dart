import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/circles_bloc.dart';

import 'scale_fade_animatoin.dart';

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

  static const double SIZE = 300.0;

  @override
  State<StatefulWidget> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  AnimationController _animationController;

  final Color _randomColor = _RandomColor().get();

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        //print(status);
        if (status == AnimationStatus.completed) {
          widget.bloc.circleDeletion.add(widget);
        }
      });

    super.initState();
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    _playAnimation();

    return Positioned(
      left: widget.x,
      top: widget.y,
      child: ScaleFadeAnimation(
        controller: _animationController.view,
        child: CustomPaint(
          foregroundPainter: _CirclePainter(_randomColor),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(this.circleColor);

  final Color circleColor;
  final Paint shapePainter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circle = shapePainter..color = circleColor;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _RandomColor {
  final List<Color> colors = Colors.primaries;

  Color get() {
    return colors[Random.secure().nextInt(colors.length)].withAlpha(200);
  }
}
