import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthDoneState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}

class AuthLoadingState extends AuthState {}
