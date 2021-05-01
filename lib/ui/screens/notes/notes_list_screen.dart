import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/ui/screens/auth/auth_screen.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_cubit.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_states.dart';
import 'package:notes/ui/widgets/note_item.dart';

import 'note_screen.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NotesListCubit _notesListCubit;

  @override
  void initState() {
    super.initState();
    _notesListCubit = NotesListCubit(RepositoryProvider.of<NotesRepository>(context));
    _notesListCubit.loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (selected) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            itemBuilder: (BuildContext itemContext) {
              return [PopupMenuItem<String>(value: 'LogOut', child: Text('LogOut'))];
            },
          ),
        ],
      ),
      body: BlocConsumer<NotesListCubit, NotesListState>(
        cubit: _notesListCubit,
        listener: (newContext, state) {
          if (state is NotesListFailedState) {
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
          if (state is NotesListLoadingState || state is NotesListInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesListFailedState) {
            return _buildTryAgain();
          } else if (state is NotesListLoadedState) {
            return ListView.separated(
              itemBuilder: (BuildContext itemContext, int index) {
                final note = state.notes[index];
                return NoteItem(
                  title: note.title,
                  date: note.dateCreated,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: note,
                        onEditingFinished: (String body, String title) {
                          Navigator.of(context).pop();
                          _notesListCubit.editNote(note);
                        },
                      ),
                      fullscreenDialog: true,
                    ),
                  ),
                  onLongTap: () => showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text('Deleting'),
                      content: Text('Do u want delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _notesListCubit.deleteNote(note.id);
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
              itemCount: null,
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          } else if (state is NotesListEmptyState) {
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
            builder: (context) => NoteScreen(
              onEditingFinished: (String body, String title) {
                Navigator.of(context).pop();
                _notesListCubit.addNote(title, body);
              },
            ),
          ),
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTryAgain() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _notesListCubit.loadNotes(true);
        },
        child: Text('Reload'),
      ),
    );
  }
}
