import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taptaptap2/widget/shape_widget.dart';

class ShapesBloc implements Bloc {
  ShapesBloc() {
    _addController.stream.listen((ShapeWidget shape) {
      _cachedShapes.add(shape);
      _shapes.add(_cachedShapes);
      _shapeCount.add(_cachedShapes.length);
    });
    _deleteController.stream.listen((ShapeWidget shape) {
      _cachedShapes.remove(shape);
      _shapes.add(_cachedShapes);
      _shapeCount.add(_cachedShapes.length);
    });
  }

  final BehaviorSubject<List<ShapeWidget>> _shapes =
      BehaviorSubject<List<ShapeWidget>>.seeded(<ShapeWidget>[]);
  final BehaviorSubject<int> _shapeCount = BehaviorSubject<int>.seeded(0);

  final PublishSubject<ShapeWidget> _addController =
      PublishSubject<ShapeWidget>();
  final PublishSubject<ShapeWidget> _deleteController =
      PublishSubject<ShapeWidget>();

  final List<ShapeWidget> _cachedShapes = <ShapeWidget>[];

  ValueObservable<List<ShapeWidget>> get shapes => _shapes;

  ValueObservable<int> get shapeCount => _shapeCount;

  Sink<ShapeWidget> get shapeAddition => _addController.sink;

  Sink<ShapeWidget> get shapeDeletion => _deleteController.sink;

  @override
  Future<void> dispose() async {
    await _shapes.close();
    await _shapeCount.close();
    await _addController.close();
    await _deleteController.close();
    _cachedShapes.clear();
  }
}
