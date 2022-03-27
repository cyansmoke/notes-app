import 'package:flutter/cupertino.dart';
import 'package:notes/model/order/order.dart';

@immutable
abstract class OrdersListState {}

class OrdersListInitialState extends OrdersListState {}

class OrdersListLoadingState extends OrdersListState {}

class OrdersListLoadedState extends OrdersListState {
  final List<Order> notes;

  OrdersListLoadedState(this.notes);
}

class OrdersListEmptyState extends OrdersListState {}

class OrdersListFailedState extends OrdersListState {
  final String error;

  OrdersListFailedState(this.error);
}
