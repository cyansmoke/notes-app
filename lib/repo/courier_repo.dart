import 'package:notes/api/courier/courier_client.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/util/util.dart';

class CourierRepository {
  final UserRepository _userRepository;
  final OrdersRepository _ordersRepository;
  final CourierApiClient _apiClient;
  List<Order> _orders;

  CourierRepository(this._userRepository, this._ordersRepository, this._apiClient)
      : _orders = _ordersRepository.getAllOrders();

  List<Order> getOrdersForToday() {
    _orders = _ordersRepository.getAllOrders();
    return _orders.where((element) => element.createdTime.isToday()).toList();
  }

  List<Order> getOptimizedOrdersForToday() {
    return _orders.where((element) => element.createdTime.isToday()).toList();
  }

  Future<void> markOrderDone(Order order) async {
    await _ordersRepository.completeOrder(order.id);
    updateOrders();
  }

  void updateOrders() {
    _orders = _ordersRepository.getAllOrders();
  }
}
