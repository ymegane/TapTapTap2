import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taptaptap2/widget/shape_widget.dart';

class CirclesBloc implements Bloc {
  CirclesBloc() {
    _addController.stream.listen((ShapeWidget circle) {
      _cachedCircles.add(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
    _deleteController.stream.listen((ShapeWidget circle) {
      _cachedCircles.remove(circle);
      _circles.add(_cachedCircles);
      _circleCount.add(_cachedCircles.length);
    });
  }

  final BehaviorSubject<List<ShapeWidget>> _circles =
      BehaviorSubject<List<ShapeWidget>>.seeded(<ShapeWidget>[]);
  final BehaviorSubject<int> _circleCount = BehaviorSubject<int>.seeded(0);

  final PublishSubject<ShapeWidget> _addController =
      PublishSubject<ShapeWidget>();
  final PublishSubject<ShapeWidget> _deleteController =
      PublishSubject<ShapeWidget>();

  final List<ShapeWidget> _cachedCircles = <ShapeWidget>[];

  ValueObservable<List<ShapeWidget>> get circles => _circles;

  ValueObservable<int> get circleCount => _circleCount;

  Sink<ShapeWidget> get circleAddition => _addController.sink;

  Sink<ShapeWidget> get circleDeletion => _deleteController.sink;

  @override
  void dispose() {
    _circles.close();
    _circleCount.close();
    _addController.close();
    _deleteController.close();
  }
}
