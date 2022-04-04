import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/model/note.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/auth_screen.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_cubit.dart';
import 'package:notes/ui/screens/notes/bloc/orders_list_states.dart';
import 'package:notes/ui/screens/user/user_screen.dart';
import 'package:notes/ui/widgets/note_item.dart';
import 'package:notes/ui/widgets/order_item.dart';

import 'note_screen.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  OrdersListCubit _notesListCubit;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() => setState(() {}));
    _notesListCubit = OrdersListCubit(RepositoryProvider.of<OrdersRepository>(context));
    _notesListCubit.loadOrders();
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
          cubit: _notesListCubit,
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
              final filteredNotes = <Order>[]..addAll(state.notes);
              if (_searchTextController.text.isNotEmpty) {
                // filteredNotes.removeWhere((element) =>
                // !(element.title.contains(_searchTextController.text) ||
                //     element.body.contains(_searchTextController.text)));
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
                      final note = filteredNotes[index];
                      return OrderItem(
                        title: note.address,
                        date: note.createdTime.toIso8601String(),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                              // note: note,
                              onEditingFinished: (String body, String title) {
                                Navigator.of(context).pop();
                                // TODO(ilia): add fields to provide body, description, address and supposed time period
                                // _notesListCubit.editOrder(newNote);
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
                                  _notesListCubit.deleteOrder(note.id);
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
                    itemCount: filteredNotes.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                  ),
                ],
              );
            } else if (state is OrdersListEmptyState) {
              return Center(
                child: Text(
                  'List is empty\nLets create a first note!',
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
                onEditingFinished: (String body, String title) {
                  Navigator.of(context).pop();
                  // _notesListCubit.addOrder(title, body);
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
          _notesListCubit.loadOrders(true);
        },
        child: Text('Reload'),
      ),
    );
  }
}
