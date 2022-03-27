import 'package:notes/api/user/user_client.dart';
import 'package:notes/model/latlng.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/order/orders.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';

class MockedUserApiClient implements UserApiClient {
  final user = User(
    1,
    'testLogin',
    'testPass',
    'test@email.com',
    '+79991113322',
    'Saint-P',
  );

  Future<Token> signIn(User user) => Future.value(Token('token'));

  Future<Token> signUp(User user) => Future.value(Token('token'));

  Future<User> getUser(String authToken) async {
    return user;
  }
}
