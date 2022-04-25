import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/ui/screens/auth/auth_screen.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_cubit.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_states.dart';
import 'package:notes/ui/screens/user/user_screen.dart';
import 'package:notes/ui/widgets/order_item.dart';

import 'order_screen.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  OrdersListCubit _ordersListCubit;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() => setState(() {}));
    _ordersListCubit = OrdersListCubit(
      RepositoryProvider.of(context),
      RepositoryProvider.of(context),
      RepositoryProvider.of(context),
    );
    _ordersListCubit.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: (selected) {
                if (selected == 'LogOut') {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
                  RepositoryProvider.of<OrdersRepository>(context).clearOrders();
                } else if (selected == 'User') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserScreen(), fullscreenDialog: true));
                }
              },
              itemBuilder: (BuildContext itemContext) {
                return [
                  PopupMenuItem<String>(value: 'LogOut', child: Text('LogOut')),
                  PopupMenuItem<String>(value: 'User', child: Text('Edit User')),
                ];
              },
            ),
          ],
        ),
        body: BlocConsumer<OrdersListCubit, OrdersListState>(
          cubit: _ordersListCubit,
          listener: (newContext, state) {
            if (state is OrdersListFailedState) {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Container(
                      child: Text(state.error),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text('OK'),
                      )
                    ],
                  );
                },
              );
            }
          },
          builder: (newContext, state) {
            if (state is OrdersListLoadingState || state is OrdersListInitialState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrdersListFailedState) {
              return _buildTryAgain();
            } else if (state is OrdersListLoadedState) {
              final filteredOrders = <Order>[]..addAll(state.notes);
              if (_searchTextController.text.isNotEmpty) {
                filteredOrders.removeWhere((element) =>
                    !(element.title.contains(_searchTextController.text) ||
                        element.description.contains(_searchTextController.text)) ||
                    element.address.contains(_searchTextController.text));
              }
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext itemContext, int index) {
                      final order = filteredOrders[index];
                      return OrderItem(
                        title: order.address,
                        date: order.createdTime.toIso8601String(),
                        isDone: order.isDone,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                              order: order,
                              onEditingFinished: (Order order) {
                                Navigator.of(context).pop();
                                _ordersListCubit.editOrder(order);
                              },
                            ),
                            fullscreenDialog: true,
                          ),
                        ),
                        onLongTap: () => showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: Text('Deleting'),
                            // content: Text('Do u want delete order ${order}?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                  _ordersListCubit.deleteOrder(order.id);
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: Text('No'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: filteredOrders.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                  ),
                ],
              );
            } else if (state is OrdersListEmptyState) {
              return Center(
                child: Text(
                  'List is empty\nLets create a first order!',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderScreen(
                onEditingFinished: (Order order) {
                  Navigator.of(context).pop();
                  _ordersListCubit.addOrder(
                      order.address, order.title, order.description, order.supposedTimePeriod);
                },
              ),
            ),
          ),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _buildTryAgain() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _ordersListCubit.loadOrders(true);
        },
        child: Text('Reload'),
      ),
    );
  }
}
