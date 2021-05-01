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
                }),
      ),
    );
  }

  Widget _buildEdittingBody() {
    return Column(
      children: [
        Text('Body:'),
        TextField(controller: _bodyTextEditingController),
        Text('Title:'),
        TextField(controller: _titleTextEditingController),
      ],
    );
  }

  Widget _buildShowBody() {
    return Column(
      children: [
        Text('Title:'),
        Text(widget.note.title),
        Text('Body:'),
        Text(widget.note.body),
      ],
    );
  }
}
