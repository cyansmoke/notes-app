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
        // Order(
        //   title: 'Order 1',
        //   description: 'Bank Docs',
        //   id: Uuid().v4(),
        //   address: user.address,
        //   phoneNumber: user.phoneNumber,
        //   isDone: false,
        //   clientId: user.id,
        //   createdTime: DateTime.now().subtract(Duration(
        //     days: 4,
        //   )),
        //   supposedTimePeriod: TimePeriod.night,
        // ),
        // Order(
        //   title: 'Order 2',
        //   description: 'Toys',
        //   id: Uuid().v4(),
        //   address: user.address,
        //   phoneNumber: user.phoneNumber,
        //   isDone: false,
        //   clientId: user.id,
        //   createdTime: DateTime.now().subtract(Duration(
        //     days: 6,
        //     hours: 3,
        //     minutes: 4,
        //   )),
        //   supposedTimePeriod: TimePeriod.morning,
        // ),
        // Order(
        //   title: 'Order 3',
        //   description: 'Important Docs Order',
        //   id: Uuid().v4(),
        //   address: user.address,
        //   phoneNumber: user.phoneNumber,
        //   isDone: true,
        //   clientId: user.id,
        //   createdTime: DateTime.now().subtract(Duration(
        //     days: 10,
        //     hours: 12,
        //   )),
        //   supposedTimePeriod: TimePeriod.day,
        // ),
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
