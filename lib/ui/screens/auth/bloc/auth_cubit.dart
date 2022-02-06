import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(AuthInitialState());

  final UserRepository _repository;

  Future<void> signInUser(String login, String password) async {
    executeWithStatesUpdate(_repository.signInUser(login, password));
  }

  Future<void> signUpUser(String login, String password, String email) async {
    executeWithStatesUpdate(_repository.signUpUser(login, password, email));
  }

  Future<void> signInCourier(String login, String password) async {
    executeWithStatesUpdate(Future.value(0));
  }

  Future<void> executeWithStatesUpdate(Future functionToExecute) async {
    emit(AuthLoadingState());
    try {
      await functionToExecute;
      emit(AuthDoneState());
    } catch (e) {
      log('AuthError $e');
      emit(AuthErrorState('Sign Up causes error: ${e.toString()}'));
    }
  }
}
