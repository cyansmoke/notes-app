import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/model/order/order.dart';
import 'package:uuid/uuid.dart';

class OrderScreen extends StatefulWidget {
  final Order order;
  final Function(Order order) onEditingFinished;

  const OrderScreen({Key key, this.order, this.onEditingFinished}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isEditing = false;

  bool get isCreating => widget.order == null;

  TextEditingController _bodyTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _addressTextEditingController = TextEditingController();
  TimePeriod _supposedTime = TimePeriod.morning;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCreating
              ? 'Creation'
              : isEditing
                  ? 'Editing ${widget.order.title}'
                  : widget.order.title,
        ),
      ),
      body: isEditing || isCreating ? _buildEdittingBody() : _buildShowBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing || isCreating ? Icons.done : Icons.edit),
        onPressed: isEditing || isCreating
            ? () => widget.onEditingFinished(
                  Order(
                    isDone: false,
                    description: _bodyTextEditingController.text,
                    id: Uuid().v4(),
                    title: _titleTextEditingController.text,
                    supposedTimePeriod: _supposedTime,
                    address: _addressTextEditingController.text,
                    createdTime: DateTime.now(),
                  ),
                )
            : () => setState(() {
                  isEditing = !isEditing;
                  _bodyTextEditingController.text = widget.order.description;
                  _titleTextEditingController.text = widget.order.title;
                  _addressTextEditingController.text = widget.order.address;
                }),
      ),
    );
  }

  Widget _buildEdittingBody() {
    return Center(
      child: Column(
        children: [
          Text(
            'Title:',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            autofocus: false,
            controller: _titleTextEditingController,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            'Body:',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            autofocus: false,
            controller: _bodyTextEditingController,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 24,
          ),
          TimePeriodDropdown(
            initialValue: _supposedTime,
            onChanged: (newTimePeriod) {
              _supposedTime = newTimePeriod;
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            autofocus: false,
            controller: _addressTextEditingController,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildShowBody() {
    return Center(
      child: Column(
        children: [
          Text(
            'Title:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            widget.order.title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            'Body:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            widget.order.description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TimePeriodDropdown extends StatefulWidget {
  final Function(TimePeriod) onChanged;
  final TimePeriod initialValue;

  const TimePeriodDropdown({
    Key key,
    @required this.onChanged,
    @required this.initialValue,
  }) : super(key: key);

  @override
  State<TimePeriodDropdown> createState() => _TimePeriodDropdownState();
}

class _TimePeriodDropdownState extends State<TimePeriodDropdown> {
  TimePeriod value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Supposed Time: ',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            bottom: 24.0,
          ),
          child: DropdownButton(
            elevation: 0,
            isExpanded: true,
            value: value,
            onChanged: (newValue) => setState(() {
              widget.onChanged(newValue);
              value = newValue;
            }),
            items: [
              ...TimePeriod.values.map(
                (e) => DropdownMenuItem<TimePeriod>(
                  value: e,
                  child: Text(
                    e.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
