import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteItem extends StatelessWidget {
  final String title;
  final String date;

  const NoteItem({Key key, @required this.title, @required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            date,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
