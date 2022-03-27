import 'package:notes/api/notes/notes_client.dart';
import 'package:notes/model/note.dart';
import 'package:notes/repo/user_repo.dart';

class OrdersRepository {
  OrdersRepository(this._userRepository, this._apiClient);

  final UserRepository _userRepository;
  final NotesApiClient _apiClient;
  List<Note> _notes = [];

  String get _token => _userRepository.token;

  Future<List<Note>> getNotes([forceLoad = false]) async {
    if (forceLoad || _notes == null || _notes.isEmpty) {
      final notes = await _apiClient.getNotes(_token);
      _notes = notes?.notes ?? [];
    }
    _sortNotes();
    return _notes;
  }

  Future<void> saveNote(Note note) async {
    await _apiClient.createNote(_token, note);
    await getNotes(true);
    _sortNotes();
  }

  Future<void> deleteNote(int id) async {
    await _apiClient.deleteNote(_token, id);
    _notes..removeWhere((element) => id == element.id);
  }

  Future<void> updateNote(Note note) async {
    await _apiClient.updateNote(_token, note.id, note);
    _notes
      ..removeWhere((element) => note.id == element.id)
      ..add(note);
    _sortNotes();
  }

  void clearNotes() => _notes.clear();

  void _sortNotes() => _notes.sort((a, b) => a.id.compareTo(b.id));
}
