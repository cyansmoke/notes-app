import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_cubit.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_states.dart';
import 'package:notes/ui/widgets/note_item.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _notesListCubit,
      child: Scaffold(
        body: BlocBuilder(
          builder: (context, state) {
            if (state is NotesListLoadingState || state is NotesListInitialState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotesListFailedState) {
              return InkWell();
            } else if (state is NotesListLoadedState) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final note = state.notes[index];
                  return NoteItem(
                    title: note.title,
                    date: note.dateCreated,
                  );
                },
                itemCount: null,
                separatorBuilder: (BuildContext context, int index) => Divider(),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _buildTryAgain() {}
}
