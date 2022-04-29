import 'package:equatable/equatable.dart';

import '../repo_module.dart';

abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object> get props => [];
}

class RepoStateInit extends RepoState {}

class RepoStateLoading extends RepoState {
  const RepoStateLoading({required this.message});

  final String message;
}

class RepoStateLoaded extends RepoState {
  const RepoStateLoaded({required this.repos});

  final List<RepoModel> repos;

  @override
  List<Object> get props => [repos];

  @override
  String toString() => 'RepoStateLoaded { items: ${repos.length} }';
}

class RepoStateError extends RepoState {
  const RepoStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
