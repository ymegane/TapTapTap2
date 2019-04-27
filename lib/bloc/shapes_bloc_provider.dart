import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taptaptap2/bloc/shapes_bloc.dart';

class CirclesBlocProvider extends BlocProvider<ShapesBloc> {
  CirclesBlocProvider({
    @required Widget child,
  }) : super(
            child: child,
            creator: (BuildContext context, BlocCreatorBag bag) {
              assert(context != null);
              return ShapesBloc();
            });

  static ShapesBloc of(BuildContext context) => BlocProvider.of(context);
}
