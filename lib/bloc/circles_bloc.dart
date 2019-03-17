import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:taptaptap2/widget/circle.dart';

class CirclesBloc implements Bloc {
  final _circlesController = BehaviorSubject.seeded(List<Circle>());
  final _addController = PublishSubject<Circle>();

  final _circles = List<Circle>();

  CirclesBloc() {
    _addController
        .doOnData((positioned) => _circles.add(positioned))
        .map((positioned) => _circles)
        .pipe(_circlesController);
  }

  ValueObservable<List<Circle>> get circles => _circlesController;
  Sink<Circle> get add => _addController.sink;

  @override
  void dispose() {
    _circlesController.close();
    _addController.close();
  }
}
