import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/api/notes/notes_client.dart';
import 'package:notes/api/user/user_client.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/auth_screen.dart';

const BASE_URL = 'https://stormy-woodland-10710.herokuapp.com/';

final dio = Dio();

class LogInterceptor implements Interceptor {
  @override
  Future onError(DioError err) async {
    log(err.toString());
    log(err.response.toString());
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    log(options.data.toString());
    log(options.baseUrl + options.path);
    log(options.method);
    options.headers.forEach((key, value) {
      log('Header $key to $value ');
    });
    return options;
  }

  @override
  Future onResponse(Response response) async {
    log(response.toString());
    return response;
  }
}

void main() {
  runApp(MyApp());
  dio.interceptors.add(LogInterceptor());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(UserApiClient(dio)),
      child: RepositoryProvider<NotesRepository>(
        create: (context) => NotesRepository(
          RepositoryProvider.of<UserRepository>(context),
          NotesApiClient(dio),
        ),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: AuthScreen(),
        ),
      ),
    );
  }
}
