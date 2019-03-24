import 'package:flutter/material.dart';
import 'package:taptaptap2/widget/circle.dart';

class ScaleFadeAnimation extends StatelessWidget {
  ScaleFadeAnimation({
    Key key,
    @required this.controller,
    @required this.decoration,
  })  : opacity = Tween<double>(
          begin: 1.0,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
        ),
        width = Tween<double>(
          begin: 0.0,
          end: Circle.CIRCLE_SIZE,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
        height = Tween<double>(
          begin: 0.0,
          end: Circle.CIRCLE_SIZE,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
        padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(
            left: Circle.CIRCLE_SIZE / 2,
            top: Circle.CIRCLE_SIZE / 2,
          ),
          end: const EdgeInsets.only(
            left: 0,
            top: 0,
          ),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<EdgeInsets> padding;
  final Animation<double> width;
  final Animation<double> height;
  final Decoration decoration;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: decoration,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
