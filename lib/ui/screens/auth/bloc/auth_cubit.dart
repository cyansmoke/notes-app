import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(AuthInitialState());

  final UserRepository _repository;

  Future<void> signInUser(String login, String password) async {
    emit(AuthLoadingState());
    try {
      await _repository.signInUser(login, password);
      emit(AuthDoneState());
    } catch (e) {
      log('AuthError $e');
      emit(AuthErrorState('Sign In causes error: ${e.toString()}'));
    }
  }

  Future<void> signUpUser(String login, String password, String email) async {
    emit(AuthLoadingState());
    try {
      await _repository.signUpUser(login, password, email);
      emit(AuthDoneState());
    } catch (e) {
      log('AuthError $e');
      emit(AuthErrorState('Sign Up causes error: ${e.toString()}'));
    }
  }
}
