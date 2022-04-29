import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../user_module.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository}) : super(UserStateInit()) {
    on<UserTextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<LoadMoreUser>(_onLoadMore, transformer: debounce(_duration));
    on<UserNavChanged>(_onNavPageChanged, transformer: debounce(_duration));
    on<UserPageChanged>(_onGoToPageChanged, transformer: debounce(_duration));
  }

  bool onLoadMore = false;
  bool onNavPage = false;
  int page = 1;
  int perPage = 30;
  String term = '';
  int totalCount = 0;
  int totalPage = 1;
  final UserRepository userRepository;
  List<UserModel> users = <UserModel>[];

  void _onNavPageChanged(UserNavChanged event, Emitter<UserState> emit) async {
    if (term.isNotEmpty && users.isNotEmpty) {
      emit(
        UserStateLoading(message: 'Loading users...'),
      );
      try {
        final results = await userRepository.search(
          'q=' +
              term +
              '&page=' +
              (event.nav == 'next' ? page + 1 : page - 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        users = results.items;
        totalCount = results.totalCount;
        emit(UserStateLoaded(users: users));
        event.nav == 'next' ? page++ : page--;
      } catch (error) {
        emit(
          error is UserError
              ? UserStateError(error.message)
              : UserStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onLoadMore(LoadMoreUser event, Emitter<UserState> emit) async {
    final state = this.state;
    if (state is UserStateLoaded && users.length < totalCount) {
      emit(
        UserStateLoading(message: 'Loading users...'),
      );
      try {
        final results = await userRepository.search(
          'q=' +
              term +
              '&page=' +
              (page + 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        users = users + results.items;
        totalCount = results.totalCount;
        emit(UserStateLoaded(users: users));
        page++;
      } catch (error) {
        emit(
          error is UserError
              ? UserStateError(error.message)
              : UserStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onGoToPageChanged(
      UserPageChanged event, Emitter<UserState> emit) async {}

  void _onTextChanged(UserTextChanged event, Emitter<UserState> emit) async {
    term = event.text;
    if (term.isEmpty) return emit(UserStateInit());
    emit(
      UserStateLoading(message: 'Loading users...'),
    );
    try {
      page = 1;
      final results = await userRepository.search(
        'q=' +
            term +
            '&page=' +
            page.toString() +
            '&per_page=' +
            perPage.toString(),
      );
      users = results.items;
      totalCount = results.totalCount;
      totalPage = (totalCount / perPage).ceil();
      emit(UserStateLoaded(users: users));
    } catch (error) {
      emit(
        error is UserError
            ? UserStateError(error.message)
            : UserStateError('Something went wrong...'),
      );
    }
  }
}
