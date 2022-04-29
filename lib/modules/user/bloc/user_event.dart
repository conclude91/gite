import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserTextChanged extends UserEvent {
  const UserTextChanged({
    required this.text,
  });

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'UserTextChanged { text: $text }';
}

class LoadMoreUser extends UserEvent {}

class UserPageChanged extends UserEvent {
  const UserPageChanged({required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageChanged { page: $page }';
}

class UserNavChanged extends UserEvent {
  const UserNavChanged({required this.nav});

  final String nav;

  @override
  List<Object> get props => [nav];

  @override
  String toString() => 'UserNavChanged { nav: $nav }';
}
