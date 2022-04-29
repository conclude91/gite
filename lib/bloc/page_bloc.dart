import 'package:flutter_bloc/flutter_bloc.dart';

class PageBloc extends Cubit<int> {
  PageBloc() : super(1);

  void next() => emit(state + 1);

  void prev() => emit(state - 1);
}
