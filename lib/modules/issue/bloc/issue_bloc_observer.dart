import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(change.toString());
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint(event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint(transition.toString());
    super.onTransition(bloc, transition);
  }
}
