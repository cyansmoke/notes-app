import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/user.dart';
import 'package:notes/repo/courier_repo.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_states.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  final OrdersRepository _repository;
  final CourierRepository _courierRepository;
  final UserRepository _userRepository;
  bool get isCourier => _userRepository.isCourier;

  OrdersListCubit(this._repository, this._courierRepository, this._userRepository)
      : super(OrdersListInitialState());

  void loadOrders([forceUpdate = false]) async {
    emit(OrdersListLoadingState());
    try {
      List<Order> notes;
      if (_userRepository.isCourier) {
        notes = _courierRepository.getOrdersForToday();
      } else {
        notes = await _repository.getOrders(forceUpdate);
      }
      if (notes?.isEmpty ?? true) {
        emit(OrdersListEmptyState());
      } else {
        emit(OrdersListLoadedState(notes));
      }
    } catch (e, stackTrace) {
      emit(OrdersListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void addOrder(
    String address,
    String title,
    String description,
    TimePeriod supposedTimePeriod,
  ) async {
    emit(OrdersListLoadingState());
    try {
      final newOrder = Order(
        id: null,
        address: address,
        title: title,
        phoneNumber: null,
        isDone: false,
        clientId: null,
        createdTime: DateTime.now(),
        description: description,
        supposedTimePeriod: supposedTimePeriod,
      );
      await _repository.createOrder(newOrder);
      loadOrders(true);
    } catch (e, stackTrace) {
      emit(OrdersListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void deleteOrder(String id) async {
    emit(OrdersListLoadingState());
    try {
      await _repository.deleteOrder(id);
      loadOrders();
    } catch (e, stackTrace) {
      emit(OrdersListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void editOrder(Order note) async {
    emit(OrdersListLoadingState());
    try {
      await _repository.updateOrder(note);
      loadOrders(true);
    } catch (e, stackTrace) {
      emit(OrdersListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void markOrderAsDone(Order order) async {
    emit(OrdersListLoadingState());
    try {
      await _courierRepository.markOrderDone(order);
      loadOrders(true);
    } catch (e, stackTrace) {
      emit(OrdersListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  User getUserFromOrder(int clientId) {
    return _userRepository.getUserFromId(clientId);
  }
}
