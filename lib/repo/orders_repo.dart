import 'dart:developer';

import 'package:notes/api/orders/mocked_orders_client.dart';
import 'package:notes/api/orders/orders_client.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/user.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:uuid/uuid.dart';

class OrdersRepository {
  OrdersRepository(this._userRepository, this._apiClient);

  final UserRepository _userRepository;
  final OrdersApiClient _apiClient;
  List<Order> _orders = [];
  final Map<int, List<Order>> _userOrdersMap = {};

  String get _token => _userRepository.token;
  User get user => _userRepository.currentUser;

  Future<List<Order>> getOrders([forceLoad = false]) async {
    if (_orders == null || _orders.isEmpty) {
      final userOrders = _userOrdersMap[user.id];
      if (userOrders?.isNotEmpty ?? false) {
        _orders = userOrders;
      }
      if (!(_apiClient is MockedOrdersApiClient) || _orders == null || _orders.isEmpty) {
        final orders = await _apiClient.getOrders(_token, user);
        _orders = orders?.orders ?? [];
      }
    }
    _sortOrders();
    _saveOrdersToUser();
    return _orders;
  }

  Future<void> deleteOrder(String id) async {
    await _apiClient.deleteOrder(_token, id);
    _orders.removeWhere((element) => id == element.id);
    _saveOrdersToUser();
    _sortOrders();
  }

  Future<void> createOrder(Order order) async {
    await _apiClient.createOrder(_token, order.id, order);
    order.clientId = user.id;
    order.id = Uuid().v4();
    order.phoneNumber = user.phoneNumber;
    _orders.add(order);
    _saveOrdersToUser();
    _sortOrders();
  }

  Future<void> completeOrder(String id) async {
    try {
      await _apiClient.completeOrder(_token, id);
      final _order = _orders.firstWhere((element) => element.id == id, orElse: () => null);
      _orders.remove(_order);
      _order.isDone = true;
      _orders.add(_order);
    } catch (e) {
      log(e);
    }
  }

  Future<void> updateOrder(Order order) async {
    try {
      await _apiClient.updateOrder(_token, order.id, order);
      final _order = _orders.firstWhere((element) => element.id == order.id, orElse: () => null);
      _orders.remove(_order);
      _orders.add(order);
    } catch (e) {
      log(e);
    }
  }

  void _saveOrdersToUser() {
    _userOrdersMap[user.id] = List.from(_orders);
  }

  List<Order> getAllOrders() {
    final List<Order> _allOrdersList = [];
    _userOrdersMap.values.forEach((element) {
      _allOrdersList.addAll(element);
    });
    return _allOrdersList;
  }

  void clearOrders() => _orders.clear();

  void _sortOrders() => _orders.sort((a, b) => a.id.compareTo(b.id));
}
