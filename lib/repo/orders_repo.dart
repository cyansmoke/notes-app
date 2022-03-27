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

  String get _token => _userRepository.token;
  User user;

  Future<List<Order>> getOrders([forceLoad = false]) async {
    if (forceLoad || _orders == null || _orders.isEmpty) {
      if (user == null) {
        await _getUser();
      }
      final orders = await _apiClient.getOrders(_token, user);
      _orders = orders?.orders ?? [];
    }
    _sortOrders();
    return _orders;
  }

  Future<void> deleteOrder(String id) async {
    await _apiClient.deleteOrder(_token, id);
    _orders.removeWhere((element) => id == element.id);
  }

  Future<void> createOrder(Order order) async {
    await _apiClient.createOrder(_token, order.id, order);
    _orders.add(order);
    if (user == null) {
      await _getUser();
    }
    order.clientId = user.id;
    order.id = Uuid().v4();
    _sortOrders();
  }

  Future<void> completeOrder(String id) async {
    await _apiClient.completeOrder(_token, id);
    final _order = _orders.firstWhere((element) => element.id == id, orElse: () => null);
    _orders.remove(_order);
    _order.isDone = true;
    _orders.add(_order);
  }

  Future<void> updateOrder(Order order) async {
    await _apiClient.updateOrder(_token, order.id, order);
    final _order = _orders.firstWhere((element) => element.id == order.id, orElse: () => null);
    _orders.remove(_order);
    _orders.add(order);
  }

  Future<User> _getUser() async {
    return user ??= await _userRepository.getUser();
  }

  void clearOrders() => _orders.clear();

  void _sortOrders() => _orders.sort((a, b) => a.id.compareTo(b.id));
}
