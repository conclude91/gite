import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../issue_module.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueBloc({required this.issueRepository}) : super(IssueStateInit()) {
    on<IssueTextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<LoadMoreIssue>(_onLoadMore, transformer: debounce(_duration));
    on<IssueNavChanged>(_onNavPageChanged, transformer: debounce(_duration));
    on<IssuePageChanged>(_onGoToPageChanged, transformer: debounce(_duration));
  }

  final IssueRepository issueRepository;
  List<IssueModel> issues = <IssueModel>[];
  bool onLoadMore = false;
  bool onNavPage = false;
  int page = 1;
  int perPage = 30;
  String term = '';
  int totalCount = 0;
  int totalPage = 1;

  void _onNavPageChanged(
      IssueNavChanged event, Emitter<IssueState> emit) async {
    if (term.isNotEmpty && issues.isNotEmpty) {
      emit(
        IssueStateLoading(message: 'Loading issues...'),
      );
      try {
        final results = await issueRepository.search(
          'q=' +
              term +
              '&page=' +
              (event.nav == 'next' ? page + 1 : page - 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        issues = results.items;
        totalCount = results.totalCount;
        emit(IssueStateLoaded(issues: issues));
        event.nav == 'next' ? page++ : page--;
      } catch (error) {
        emit(
          error is IssueError
              ? IssueStateError(error.message)
              : IssueStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onLoadMore(LoadMoreIssue event, Emitter<IssueState> emit) async {
    final state = this.state;
    if (state is IssueStateLoaded && issues.length < totalCount) {
      emit(
        IssueStateLoading(message: 'Loading repos...'),
      );
      try {
        final results = await issueRepository.search(
          'q=' +
              term +
              '&page=' +
              (page + 1).toString() +
              '&per_page=' +
              perPage.toString(),
        );
        issues = issues + results.items;
        totalCount = results.totalCount;
        emit(IssueStateLoaded(issues: issues));
        page++;
      } catch (error) {
        emit(
          error is IssueError
              ? IssueStateError(error.message)
              : IssueStateError('Something went wrong...'),
        );
      }
    }
  }

  void _onGoToPageChanged(
      IssuePageChanged event, Emitter<IssueState> emit) async {}

  void _onTextChanged(IssueTextChanged event, Emitter<IssueState> emit) async {
    term = event.text;
    if (term.isEmpty) return emit(IssueStateInit());
    emit(IssueStateLoading(message: 'Loading repos...'));
    try {
      page = 1;
      final results = await issueRepository.search(
        'q=' +
            term +
            '&page=' +
            page.toString() +
            '&per_page=' +
            perPage.toString(),
      );
      issues = results.items;
      totalCount = results.totalCount;
      totalPage = (totalCount / perPage).ceil();
      emit(IssueStateLoaded(issues: issues));
    } catch (error) {
      emit(
        error is IssueError
            ? IssueStateError(error.message)
            : IssueStateError('Something went wrong...'),
      );
    }
  }
}
