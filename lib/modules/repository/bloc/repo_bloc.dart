import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../repo_module.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc({required this.repoRepository}) : super(RepoStateInit()) {
    on<RepoTextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<LoadMoreRepo>(_onLoadMore, transformer: debounce(_duration));
    on<RepoNavChanged>(_onNavPageChanged, transformer: debounce(_duration));
    on<RepoPageChanged>(_onGoToPageChanged, transformer: debounce(_duration));
  }

  bool onLoadMore = false;
  bool onNavPage = false;
  int page = 1;
  int perPage = 30;
  final RepoRepository repoRepository;
  List<RepoModel> repos = <RepoModel>[];
  String term = '';
  int totalCount = 0;
  int totalPage = 1;

  void _onNavPageChanged(RepoNavChanged event, Emitter<RepoState> emit) async {
    if (term.isNotEmpty && repos.isNotEmpty) {
      emit(
        RepoStateLoading(message: 'Loading repos...'),
      );
      try {
        final results = await repoRepository.search(
          'q=' +
              term +
              '&page=' +
              (event.nav == 'next' ? page + 1 : page - 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        repos = results.items;
        totalCount = results.totalCount;
        emit(RepoStateLoaded(repos: repos));
        event.nav == 'next' ? page++ : page--;
      } catch (error) {
        emit(
          error is RepoError
              ? RepoStateError(error.message)
              : RepoStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onLoadMore(LoadMoreRepo event, Emitter<RepoState> emit) async {
    final state = this.state;
    if (state is RepoStateLoaded && repos.length < totalCount) {
      emit(
        RepoStateLoading(message: 'Loading repos...'),
      );
      try {
        final results = await repoRepository.search(
          'q=' +
              term +
              '&page=' +
              (page + 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        repos = repos + results.items;
        totalCount = results.totalCount;
        emit(RepoStateLoaded(repos: repos));
        page++;
      } catch (error) {
        emit(
          error is RepoError
              ? RepoStateError(error.message)
              : RepoStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onGoToPageChanged(
      RepoPageChanged event, Emitter<RepoState> emit) async {}

  void _onTextChanged(RepoTextChanged event, Emitter<RepoState> emit) async {
    term = event.text;
    if (term.isEmpty) return emit(RepoStateInit());
    emit(RepoStateLoading(message: 'Loading repos...'));
    try {
      page = 1;
      final results = await repoRepository.search(
        'q=' +
            term +
            '&page=' +
            page.toString() +
            '&per_page=' +
            perPage.toString(),
      );
      repos = results.items;
      totalCount = results.totalCount;
      totalPage = (totalCount / perPage).ceil();
      emit(RepoStateLoaded(repos: repos));
    } catch (error) {
      emit(
        error is RepoError
            ? RepoStateError(error.message)
            : RepoStateError('Something went wrong...'),
      );
    }
  }
}
