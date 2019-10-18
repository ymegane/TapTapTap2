import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:rxdart/rxdart.dart';
import 'package:soundpool/soundpool.dart';
import 'package:taptaptap2/bloc/shapes_bloc.dart';
import 'package:taptaptap2/bloc/shapes_bloc_provider.dart';
import 'package:taptaptap2/widget/shape_widget.dart';

class Playground extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  PublishSubject<DragUpdateDetails> _moveEvents;
  PublishSubject<ShapesBloc> _soundController;

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
    final ShapesBloc bloc = CirclesBlocProvider.of(context);
    _moveEvents = PublishSubject<DragUpdateDetails>();
    _moveEvents
        .throttleTime(const Duration(milliseconds: 100))
        .listen((DragUpdateDetails details) {
      _handleMove(context, bloc, details);
    });

    _soundController = PublishSubject<ShapesBloc>();
    _soundController
        .throttleTime(const Duration(milliseconds: 2000))
        .listen((ShapesBloc bloc) {
      _playEffect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShapesBloc bloc = CirclesBlocProvider.of(context);
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
        child: StreamBuilder<List<ShapeWidget>>(
          stream: bloc.shapes,
          initialData: bloc.shapes.value,
          builder: (_, AsyncSnapshot<List<ShapeWidget>> snap) => Stack(
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
      BuildContext context, ShapesBloc bloc, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    _addCircle(bloc, localOffset);
  }

  void _handleMove(
      BuildContext context, ShapesBloc bloc, DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    _addCircle(bloc, localOffset);
  }

  Future<void> _addCircle(ShapesBloc bloc, Offset offset) async {
    const double circleRadius = ShapeWidget.SIZE / 2;

    bloc.shapeAddition.add(
      ShapeWidget(
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
    final int sound6 = await rootBundle
        .load('assets/ani_ge_flog03.mp3')
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    return <int>[sound1, sound2, sound3, sound4, sound5, sound6];
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
