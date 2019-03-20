import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:taptaptap2/widget/circle.dart';

class CirclesBloc implements Bloc {
  final _circles = BehaviorSubject<List<Circle>>.seeded([]);
  final _circleCount = BehaviorSubject<int>.seeded(0);

  final _addController = PublishSubject<Circle>();
  final _deleteController = PublishSubject<Circle>();

  final _cachedCircles = List<Circle>();

  CirclesBloc() {
    _addController.stream.listen((circle) {
      _cachedCircles.add(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
    _deleteController.stream.listen((circle) {
      _cachedCircles.remove(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
  }

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
