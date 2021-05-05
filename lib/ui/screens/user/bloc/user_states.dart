import 'package:flutter/cupertino.dart';
import 'package:notes/model/user.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState(this.user);
}

class UserDeletedState extends UserState {}
