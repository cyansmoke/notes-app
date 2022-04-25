import 'dart:math';

import 'package:notes/api/user/user_client.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/order/orders.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  UserRepository(this._apiClient);

  final UserApiClient _apiClient;

  String get token => 'Bearer $_token';
  String _token;
  List<User> _loggedInUsers = [];
  User _currentUser;
  bool isCourier = false;

  Future<String> signInUser(String login, String password, [bool isCourier = false]) async {
    this.isCourier = isCourier;
    return _authUser(User(null, login, password), false);
  }

  Future<String> signUpUser(String login, String password, String email) async {
    final userToSignUp = User(
      Random().nextInt(1000),
      login,
      password,
      email,
      '+7999999999',
      'User Address ${Uuid().v4()}',
    );
    return _authUser(userToSignUp, true);
  }

  Future<String> _authUser(User user, bool isSignUp) async {
    var existingUser =
        _loggedInUsers.firstWhere((element) => element.login == user.login, orElse: () => null);
    if (existingUser == null) {
      if (!isSignUp) {
        throw Exception('User is not registered yet');
      }
      _loggedInUsers.add(user);
      existingUser = user;
    } else {
      if (isSignUp) {
        throw Exception('User already registered');
      }
    }

    Token newToken;
    if (existingUser.email == null) {
      newToken = await _apiClient.signIn(existingUser);
    } else {
      newToken = await _apiClient.signUp(existingUser);
    }
    _token = newToken.token;
    _currentUser = existingUser;
    return _token;
  }

  Future<User> getUser() async => _currentUser;

  Future<Orders> getOrders(String authToken) async {}

  Future<Order> createOrder(Order order) async {}
}
