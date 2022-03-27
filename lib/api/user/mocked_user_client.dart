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

  @override
  Future<Order> createOrder(String authToken, int id) async {
    return Order(
      'address',
      LatLng(10.0, 20.0),
      user.phoneNumber,
      false,
      id,
      DateTime.now(),
      TimePeriod.day,
    );
  }

  @override
  Future<Orders> getOrders(String authToken) async {
    return Orders(
      [
        Order(
          user.address,
          LatLng(10.0, 20.0),
          user.phoneNumber,
          false,
          user.id,
          DateTime.now().subtract(Duration(days: 4)),
          TimePeriod.night,
        ),
        Order(
          user.address,
          LatLng(10.0, 20.0),
          user.phoneNumber,
          false,
          user.id,
          DateTime.now().subtract(Duration(days: 10)),
          TimePeriod.morning,
        ),
        Order(
          user.address,
          LatLng(10.0, 20.0),
          user.phoneNumber,
          false,
          user.id,
          DateTime.now().subtract(Duration(days: 10, hours: 12)),
          TimePeriod.day,
        ),
      ],
    );
  }
}
