import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter/gestures.dart';
import 'package:soundpool/soundpool.dart';

import 'package:taptaptap2/bloc/circles_bloc.dart';
import 'package:taptaptap2/bloc/circles_bloc_provider.dart';
import 'package:taptaptap2/widget/circle.dart';

class Circles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  PublishSubject<DragUpdateDetails> _moveEvents;
  PublishSubject<CirclesBloc> _soundController;

  Soundpool _soundpool;
  final List<int> _soundEffects = <int>[];

  @override
  void initState() {
    super.initState();
    // load sound effects
    _soundpool = Soundpool(streamType: StreamType.music, maxStreams: 5);

    _loadEffectSounds(context).then((List<int> effects) {
      _soundEffects.addAll(effects);
    });
    final CirclesBloc bloc = CirclesBlocProvider.of(context);
    _moveEvents = PublishSubject<DragUpdateDetails>();
    _moveEvents
        .throttle(Duration(milliseconds: 100))
        .listen((DragUpdateDetails details) {
      _handleMove(context, bloc, details);
    });

    _soundController = PublishSubject<CirclesBloc>();
    _soundController
        .throttle(Duration(milliseconds: 500))
        .listen((CirclesBloc bloc) {
      _playEffect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CirclesBloc bloc = CirclesBlocProvider.of(context);
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory<GestureRecognizer>>{
        MultiTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<MultiTapGestureRecognizer>(
                () => MultiTapGestureRecognizer(),
                (MultiTapGestureRecognizer instance) {
          instance.onTapDown = (int pointer, TapDownDetails details) =>
              _handleTap(context, bloc, details);
        }),
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
                () => PanGestureRecognizer(), (PanGestureRecognizer instance) {
          instance.onUpdate =
              (DragUpdateDetails details) => _moveEvents.add(details);
        }),
      },
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
    _soundController.close();
    _soundpool.release();
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

  Future<void> _addCircle(CirclesBloc bloc, Offset offset) async {
    const double circleRadius = Circle.CIRCLE_SIZE / 2;

    bloc.circleAddition.add(
      Circle(
        key: UniqueKey(),
        x: offset.dx - circleRadius,
        y: offset.dy - circleRadius,
        bloc: bloc,
      ),
    );
    _soundController.add(bloc);
  }

  Future<List<int>> _loadEffectSounds(BuildContext context) async {
    final int sound1 = await rootBundle
        .load('assets/ani_ge_chicken_koke03.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    final int sound2 = await rootBundle
        .load('assets/ani_ge_dog_wan01.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    final int sound3 = await rootBundle
        .load('assets/ani_ge_horse01.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    final int sound4 = await rootBundle
        .load('assets/ani_ge_owl02.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    final int sound5 = await rootBundle
        .load('assets/ani_ge_ushi02.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    return <int>[sound1, sound2, sound3, sound4, sound5];
  }

  final Random random = Random.secure();
  Future<void> _playEffect() async {
    if (_soundEffects.isEmpty) {
      return;
    }
    final int soundId = _soundEffects[random.nextInt(_soundEffects.length)];
    if (soundId == -1) {
      return;
    }
    await _soundpool.play(soundId);
  }
}
