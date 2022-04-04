import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/ui/screens/notes/order_screen.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final String title;
  final String date;
  final bool isDone;
  final Function onTap;
  final Function onLongTap;

  const OrderItem({
    Key key,
    @required this.title,
    @required this.date,
    @required this.onLongTap,
    @required this.onTap,
    @required this.isDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: onLongTap,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  height: 1.6,
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy HH:ss').format(DateTime.parse(date)),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  height: 1.2,
                ),
              ),
              if (isDone) _buildCompletedRow() else _buildPendingRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedRow() {
    return Row(
      children: [
        Text('Completed'),
        Icon(Icons.done),
      ],
    );
  }

  Widget _buildPendingRow() {
    return Row(
      children: [
        Text('Pending'),
        Icon(Icons.pending_actions),
      ],
    );
  }
}
