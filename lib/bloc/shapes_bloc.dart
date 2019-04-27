import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taptaptap2/widget/shape_widget.dart';

class ShapesBloc implements Bloc {
  ShapesBloc() {
    _addController.stream.listen((ShapeWidget shape) {
      _cachedshapes.add(shape);
      _shapes.add(_cachedshapes);
      _shapeCount.add(_cachedshapes.length);
    });
    _deleteController.stream.listen((ShapeWidget shape) {
      _cachedshapes.remove(shape);
      _shapes.add(_cachedshapes);
      _shapeCount.add(_cachedshapes.length);
    });
  }

  final BehaviorSubject<List<ShapeWidget>> _shapes =
      BehaviorSubject<List<ShapeWidget>>.seeded(<ShapeWidget>[]);
  final BehaviorSubject<int> _shapeCount = BehaviorSubject<int>.seeded(0);

  final PublishSubject<ShapeWidget> _addController =
      PublishSubject<ShapeWidget>();
  final PublishSubject<ShapeWidget> _deleteController =
      PublishSubject<ShapeWidget>();

  final List<ShapeWidget> _cachedshapes = <ShapeWidget>[];

  ValueObservable<List<ShapeWidget>> get shapes => _shapes;

  ValueObservable<int> get shapeCount => _shapeCount;

  Sink<ShapeWidget> get shapeAddition => _addController.sink;

  Sink<ShapeWidget> get shapeDeletion => _deleteController.sink;

  @override
  void dispose() {
    _shapes.close();
    _shapeCount.close();
    _addController.close();
    _deleteController.close();
  }
}
