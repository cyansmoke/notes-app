import 'package:bloc/bloc.dart';
import 'package:notes/repo/notes_repo.dart';
import 'package:notes/ui/screens/notes/bloc/notes_list_states.dart';

class NotesListCubit extends Cubit<NotesListState> {
  NotesListCubit(NotesRepository repository) : super(NotesListInitialState());
}
