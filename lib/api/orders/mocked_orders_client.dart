import 'package:notes/api/orders/orders_client.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/order/orders.dart';
import 'package:notes/model/user.dart';
import 'package:uuid/uuid.dart';

class MockedOrdersApiClient implements OrdersApiClient {
  @override
  Future<Order> createOrder(String authToken, String id, Order order) async {
    return order;
  }

  @override
  Future<Orders> getOrders(
    String authToken,
    User user,
  ) async {
    return Orders(
      [
        Order(
          Uuid().v4(),
          user.address,
          user.phoneNumber,
          false,
          user.id,
          DateTime.now().subtract(Duration(
            days: 4,
          )),
          TimePeriod.night,
        ),
        Order(
          Uuid().v4(),
          user.address,
          user.phoneNumber,
          false,
          user.id,
          DateTime.now().subtract(Duration(
            days: 6,
            hours: 3,
            minutes: 4,
          )),
          TimePeriod.morning,
        ),
        Order(
          Uuid().v4(),
          user.address,
          user.phoneNumber,
          true,
          user.id,
          DateTime.now().subtract(Duration(
            days: 10,
            hours: 12,
          )),
          TimePeriod.day,
        ),
      ],
    );
  }

  @override
  Future<void> deleteOrder(String authToken, String id) async {}

  @override
  Future<void> updateOrder(String authToken, String id, Order order) async {}

  @override
  Future<void> completeOrder(String authToken, String id) async {}
}
