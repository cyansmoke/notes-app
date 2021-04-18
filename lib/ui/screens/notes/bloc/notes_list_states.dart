import 'package:flutter/cupertino.dart';
import 'package:notes/model/note.dart';

@immutable
abstract class NotesListState {}

class NotesListInitialState extends NotesListState {}

class NotesListLoadingState extends NotesListState {}

class NotesListLoadedState extends NotesListState {
  final List<Note> notes;

  NotesListLoadedState(this.notes);
}

class NotesListEmptyState extends NotesListState {}

class NotesListFailedState extends NotesListState {
  final String error;

  NotesListFailedState(this.error);
}
