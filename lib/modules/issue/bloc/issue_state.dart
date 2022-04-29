import 'package:equatable/equatable.dart';

import '../issue_module.dart';

abstract class IssueState extends Equatable {
  const IssueState();

  @override
  List<Object> get props => [];
}

class IssueStateInit extends IssueState {}

class IssueStateLoading extends IssueState {
  const IssueStateLoading({required this.message});

  final String message;
}

class IssueStateLoaded extends IssueState {
  const IssueStateLoaded({required this.issues});

  final List<IssueModel> issues;

  @override
  List<Object> get props => [issues];

  @override
  String toString() => 'IssueStateLoaded { items: ${issues.length} }';
}

class IssueStateError extends IssueState {
  const IssueStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
