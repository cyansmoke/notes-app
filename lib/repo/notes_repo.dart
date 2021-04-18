import 'package:notes/api/notes/notes_client.dart';
import 'package:notes/model/note.dart';
import 'package:notes/repo/user_repo.dart';

class NotesRepository {
  NotesRepository(this._userRepository, this._apiClient);

  final UserRepository _userRepository;
  final NotesApiClient _apiClient;
  List<Note> _notes;

  String get _token => _userRepository.token;

  Future<List<Note>> getNotes([forceLoad = false]) async {
    if (forceLoad || _notes == null) {
      final notes = await _apiClient.getNotes(_token);
      _notes = notes;
    }
    return _notes;
  }

  Future<void> saveNote(Note note) => _apiClient.createNote(_token, note);

  Future<void> deleteNote(Note note) => _apiClient.deleteNote(_token, note.id);
}
