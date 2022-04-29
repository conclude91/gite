import 'package:equatable/equatable.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();

  @override
  List<Object> get props => [];
}

class IssueTextChanged extends IssueEvent {
  const IssueTextChanged({
    required this.text,
  });

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}

class LoadMoreIssue extends IssueEvent {}

class IssuePageChanged extends IssueEvent {
  const IssuePageChanged({required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageChanged { page: $page }';
}

class IssueNavChanged extends IssueEvent {
  const IssueNavChanged({required this.nav});

  final String nav;

  @override
  List<Object> get props => [nav];

  @override
  String toString() => 'IssueNavChanged { nav: $nav }';
}
