import 'package:flutter/material.dart';

import 'package:taptaptap2/bloc/circles_bloc.dart';
import 'package:taptaptap2/bloc/circles_bloc_provider.dart';
import 'package:taptaptap2/widget/circle.dart';

class Circles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  @override
  Widget build(BuildContext context) {
    final bloc = CirclesBlocProvider.of(context);
    return GestureDetector(
      onTapDown: (TapDownDetails details) => _handleTap(context, bloc, details),
      child: Container(
        color: Colors.white,
        child: StreamBuilder<List<Circle>>(
          stream: bloc.circles,
          initialData: bloc.circles.value,
          builder: (context, snap) => Stack(
                fit: StackFit.expand,
                children: snap.data,
              ),
        ),
      ),
    );
  }

  void _handleTap(
      BuildContext context, CirclesBloc bloc, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    final circleRadius = Circle.CIRCLE_SIZE / 2;

    bloc.circleAddition.add(
      Circle(
        key: UniqueKey(),
        x: localOffset.dx - circleRadius,
        y: localOffset.dy - circleRadius,
        bloc: bloc,
      ),
    );
  }
}
