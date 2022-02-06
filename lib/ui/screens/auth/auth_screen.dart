import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/bloc/auth_cubit.dart';
import 'package:notes/ui/screens/notes/notes_list_screen.dart';

import 'bloc/auth_states.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum LoginState { Registration, Login, Courier }

class _AuthScreenState extends State<AuthScreen> {
  LoginState _currentState = LoginState.Login;
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();

  AuthCubit _authCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authCubit = AuthCubit(RepositoryProvider.of<UserRepository>(context));
  }

  String _getTitle() {
    switch (_currentState) {
      case LoginState.Registration:
        return 'Registration';
      case LoginState.Login:
        return 'Login';
      case LoginState.Courier:
        return 'Courier Login';
      default:
        return '';
    }
  }

  void executeAction() {
    switch (_currentState) {
      case LoginState.Registration:
        _authCubit.signUpUser(
            loginTextController.text, passwordTextController.text, emailTextController.text);
        break;
      case LoginState.Login:
        _authCubit.signInUser(loginTextController.text, passwordTextController.text);
        break;
      case LoginState.Courier:
        _authCubit.signInCourier(loginTextController.text, passwordTextController.text);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_getTitle()),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => setState(() => FocusScope.of(context).unfocus()),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 4.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: loginTextController,
                        decoration: InputDecoration(
                          labelText: 'Login',
                        ),
                      ),
                      TextField(
                        controller: passwordTextController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      if (_currentState == LoginState.Registration)
                        TextField(
                          controller: emailTextController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      BlocConsumer<AuthCubit, AuthState>(
                        cubit: _authCubit,
                        listener: (newContext, state) {
                          if (state is AuthErrorState) {
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Container(
                                    child: Text(state.error),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: Text('OK'),
                                    )
                                  ],
                                );
                              },
                            );
                          } else if (state is AuthDoneState) {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (routeContext) => NotesList()));
                          }
                        },
                        builder: (newContext, state) {
                          return Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: ElevatedButton(
                              child: SizedBox(
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Center(
                                    child: state is AuthLoadingState
                                        ? SizedBox(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(Colors.white),
                                              strokeWidth: 2.0,
                                            ),
                                            width: 18,
                                            height: 18,
                                          )
                                        : Text(
                                            _getTitle(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              onPressed: state is AuthLoadingState ? null : () {},
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CupertinoButton(
                        onPressed: () => setState(
                          () {
                            _currentState != LoginState.Courier
                                ? _currentState = LoginState.Courier
                                : _currentState = LoginState.Login;
                          },
                        ),
                        child: Text(_currentState != LoginState.Courier
                            ? 'Go to Courier Login'
                            : 'Back to Common Login'),
                      ),
                      Visibility(
                        visible: _currentState != LoginState.Courier,
                        child: CupertinoButton(
                          onPressed: () => setState(() {
                            _currentState == LoginState.Registration
                                ? _currentState = LoginState.Login
                                : _currentState = LoginState.Registration;
                          }),
                          child: Text(_currentState == LoginState.Registration
                              ? 'Back to Login'
                              : 'Register'),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
