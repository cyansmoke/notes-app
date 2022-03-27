import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes/model/note.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_states.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit(this._repository) : super(OrdersListInitialState());

  final OrdersRepository _repository;

  void loadOrders([forceUpdate = false]) async {
    emit(OrdersListLoadingState());
    try {
      final notes = await _repository.getOrders(forceUpdate);
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

  void addOrder(String address, TimePeriod supposedTimePeriod) async {
    emit(OrdersListLoadingState());
    try {
      final newNote = Order(
        null,
        address,
        null,
        false,
        null,
        DateTime.now(),
        supposedTimePeriod,
      );
      await _repository.createOrder(newNote);
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
}
