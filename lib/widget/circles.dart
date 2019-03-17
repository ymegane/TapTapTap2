import 'package:flutter/material.dart';

import 'package:taptaptap2/widget/circle.dart';

class Circles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  final _circleWidgets = List<Widget>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => _handleTap(context, details),
      child: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: _circleWidgets,
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    final circleRadius = Circle.CIRCLE_SIZE / 2;
    setState(() {
      _circleWidgets.add(
          Positioned(
              left: localOffset.dx - circleRadius,
              top: localOffset.dy - circleRadius,
              child: Circle()
          ),
      );
    });
  }
}
