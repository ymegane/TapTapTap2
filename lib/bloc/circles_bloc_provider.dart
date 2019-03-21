import 'package:bloc_provider/bloc_provider.dart';

import 'package:flutter/widgets.dart';
import 'package:taptaptap2/bloc/circles_bloc.dart';

class CirclesBlocProvider extends BlocProvider<CirclesBloc> {
  CirclesBlocProvider({
    @required Widget child,
  }) : super(
            child: child,
            creator: (BuildContext context, BlocCreatorBag bag) {
              assert(context != null);
              return CirclesBloc();
            });

  static CirclesBloc of(BuildContext context) => BlocProvider.of(context);
}
