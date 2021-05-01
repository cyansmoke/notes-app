import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/model/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final Function(String body, String title) onEditingFinished;

  const NoteScreen({Key key, this.note, this.onEditingFinished}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool isEditing = false;

  bool get isCreating => widget.note == null;

  TextEditingController _bodyTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCreating
              ? 'Creation'
              : isEditing
                  ? 'Editing ${widget.note.title}'
                  : widget.note.title,
        ),
      ),
      body: isEditing || isCreating ? _buildEdittingBody() : _buildShowBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing || isCreating ? Icons.done : Icons.edit),
        onPressed: isEditing || isCreating
            ? () => widget.onEditingFinished(
                _bodyTextEditingController.text, _titleTextEditingController.text)
            : () => setState(() {
                  isEditing = !isEditing;
                  _bodyTextEditingController.text = widget.note.body;
                  _titleTextEditingController.text = widget.note.title;
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
            controller: _bodyTextEditingController,
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
            widget.note.title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            'Body:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            widget.note.body,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
