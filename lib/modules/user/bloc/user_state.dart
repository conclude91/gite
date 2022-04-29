import 'package:equatable/equatable.dart';

import '../user_module.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateInit extends UserState {}

class UserStateLoading extends UserState {
  const UserStateLoading({required this.message});

  final String message;
}

class UserStateLoaded extends UserState {
  const UserStateLoaded({required this.users});

  final List<UserModel> users;

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'UserStateLoaded { items: ${users.length} }';
}

class UserStateError extends UserState {
  const UserStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
