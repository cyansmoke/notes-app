import 'package:bloc/bloc.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_states.dart';

class NotesListCubit extends Cubit<NotesListState> {
  NotesListCubit(this._repository) : super(NotesListInitialState());

  final NotesRepository _repository;

  void loadNotes() async {
    emit(NotesListLoadingState());
    try {
      final notes = await _repository.getNotes();
      if (notes?.isEmpty ?? true) {
        emit(NotesListEmptyState());
      } else {
        emit(NotesListLoadedState(notes));
      }
    } catch (e) {
      emit(NotesListFailedState(e.toString()));
    }
  }
}
