import 'package:equatable/equatable.dart';

abstract class RepoEvent extends Equatable {
  const RepoEvent();

  @override
  List<Object> get props => [];
}

class RepoTextChanged extends RepoEvent {
  const RepoTextChanged({
    required this.text,
  });

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}

class LoadMoreRepo extends RepoEvent {}

class RepoPageChanged extends RepoEvent {
  const RepoPageChanged({required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageChanged { page: $page }';
}

class RepoNavChanged extends RepoEvent {
  const RepoNavChanged({required this.nav});

  final String nav;

  @override
  List<Object> get props => [nav];

  @override
  String toString() => 'RepoNavChanged { nav: $nav }';
}
