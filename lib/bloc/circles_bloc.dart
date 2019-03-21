import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:taptaptap2/widget/circle.dart';

class CirclesBloc implements Bloc {
  CirclesBloc() {
    _addController.stream.listen((Circle circle) {
      _cachedCircles.add(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
    _deleteController.stream.listen((Circle circle) {
      _cachedCircles.remove(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
  }

  final BehaviorSubject<List<Circle>> _circles =
      BehaviorSubject<List<Circle>>.seeded(<Circle>[]);
  final BehaviorSubject<int> _circleCount = BehaviorSubject<int>.seeded(0);

  final PublishSubject<Circle> _addController = PublishSubject<Circle>();
  final PublishSubject<Circle> _deleteController = PublishSubject<Circle>();

  final List<Circle> _cachedCircles = <Circle>[];

  ValueObservable<List<Circle>> get circles => _circles;

  ValueObservable<int> get circleCount => _circleCount;

  Sink<Circle> get circleAddition => _addController.sink;

  Sink<Circle> get circleDeletion => _deleteController.sink;

  @override
  void dispose() {
    _circles.close();
    _circleCount.close();
    _addController.close();
    _deleteController.close();
  }
}
