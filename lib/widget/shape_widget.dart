import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taptaptap2/bloc/shapes_bloc.dart';
import 'package:taptaptap2/util/random_color.dart' as random_color;
import 'package:taptaptap2/util/random_shape.dart' as random_shape;

import 'scale_fade_animatoin.dart';

class ShapeWidget extends StatefulWidget {
  const ShapeWidget(
      {@required Key key,
      @required this.x,
      @required this.y,
      @required this.bloc})
      : super(key: key);

  final double x;
  final double y;
  final ShapesBloc bloc;

  static const double SIZE = 300.0;

  @override
  State<StatefulWidget> createState() => _ShapeWidgetState();
}

class _ShapeWidgetState extends State<ShapeWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  final Color _randomColor = random_color.get();

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        //print(status);
        if (status == AnimationStatus.completed) {
          widget.bloc.shapeDeletion.add(widget);
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
          foregroundPainter: _ShapePainter(
            _randomColor,
            random_shape.Shape.Circle,
          ),
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

class _ShapePainter extends CustomPainter {
  _ShapePainter(this.shapeColor, this.shapeType);

  final Color shapeColor;
  final random_shape.Shape shapeType;
  final Paint shapePainter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = shapePainter..color = shapeColor;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    switch (shapeType) {
      case random_shape.Shape.Rect:
        canvas.drawRect(Rect.fromCircle(center: center, radius: radius), paint);
        break;
      case random_shape.Shape.Circle:
        canvas.drawCircle(center, radius, paint);
        break;
      case random_shape.Shape.Triangle:
        final Path path = Path();
        path.addPolygon(<Offset>[
          Offset(center.dx, 0),
          Offset(size.width, size.height),
          Offset(0, size.height),
        ], true);
        break;
      default:
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
