import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes/model/note.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_states.dart';

class NotesListCubit extends Cubit<NotesListState> {
  NotesListCubit(this._repository) : super(NotesListInitialState());

  final NotesRepository _repository;

  void loadNotes([forceUpdate = false]) async {
    emit(NotesListLoadingState());
    try {
      final notes = await _repository.getNotes(forceUpdate);
      if (notes?.isEmpty ?? true) {
        emit(NotesListEmptyState());
      } else {
        emit(NotesListLoadedState(notes));
      }
    } catch (e, stackTrace) {
      emit(NotesListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void addNote(String title, String body) async {
    emit(NotesListLoadingState());
    try {
      final newNote = Note(body, title);
      await _repository.saveNote(newNote);
      loadNotes(true);
    } catch (e, stackTrace) {
      emit(NotesListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void deleteNote(int id) async {
    emit(NotesListLoadingState());
    try {
      await _repository.deleteNote(id);
      loadNotes();
    } catch (e, stackTrace) {
      emit(NotesListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  void editNote(Note note) async {
    emit(NotesListLoadingState());
    try {
      await _repository.updateNote(note);
      loadNotes(true);
    } catch (e, stackTrace) {
      emit(NotesListFailedState(e.toString()));
      log(e.toString());
      log(stackTrace.toString());
    }
  }
}
