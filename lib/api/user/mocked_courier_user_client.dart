import 'dart:math';

import 'package:notes/api/user/user_client.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';

class MockedUserApiClient implements UserApiClient {
  final user = User(
    Random().nextInt(100),
    'testCourier',
    'testPass',
    'test@cour.com',
    '+79132223333',
    'Saint-Petersburg',
  );

  Future<Token> signIn(User user) => Future.value(Token('courier_token'));

  Future<Token> signUp(User user) => Future.value(Token('courier_token'));

  Future<User> getUser(String authToken) async {
    return user;
  }
}
