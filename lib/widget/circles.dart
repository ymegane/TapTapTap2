import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';

import 'package:taptaptap2/bloc/circles_bloc.dart';
import 'package:taptaptap2/bloc/circles_bloc_provider.dart';
import 'package:taptaptap2/widget/circle.dart';

class Circles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  PublishSubject<DragUpdateDetails> _moveEvents;
  @override
  void initState() {
    super.initState();
    final CirclesBloc bloc = CirclesBlocProvider.of(context);
    _moveEvents = PublishSubject<DragUpdateDetails>();
    _moveEvents
        .throttle(Duration(milliseconds: 100))
        .listen((DragUpdateDetails details) {
      _handleMove(context, bloc, details);
    });
  }

  @override
  Widget build(BuildContext context) {
    final CirclesBloc bloc = CirclesBlocProvider.of(context);
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        _moveEvents.add(details);
      },
      onTapDown: (TapDownDetails details) => _handleTap(context, bloc, details),
      child: Container(
        color: Colors.white,
        child: StreamBuilder<List<Circle>>(
          stream: bloc.circles,
          initialData: bloc.circles.value,
          builder: (_, AsyncSnapshot<List<Circle>> snap) => Stack(
                fit: StackFit.expand,
                children: snap.data,
              ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _moveEvents.close();
    super.dispose();
  }

  void _handleTap(
      BuildContext context, CirclesBloc bloc, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    _addCircle(bloc, localOffset);
  }

  void _handleMove(
      BuildContext context, CirclesBloc bloc, DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    _addCircle(bloc, localOffset);
  }

  void _addCircle(CirclesBloc bloc, Offset offset) {
    const double circleRadius = Circle.CIRCLE_SIZE / 2;

    bloc.circleAddition.add(
      Circle(
        key: UniqueKey(),
        x: offset.dx - circleRadius,
        y: offset.dy - circleRadius,
        bloc: bloc,
      ),
    );
  }
}
