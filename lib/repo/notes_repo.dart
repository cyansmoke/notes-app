import 'package:notes/api/notes/notes_client.dart';
import 'package:notes/model/note.dart';

import '../main.dart';

// TODO(ilia): put auth token
class NotesRepository {
  final notesClient = NotesApiClient(dio);

  List<Note> _notes;

  Future<List<Note>> getNotes([forceLoad = false]) async {
    if (forceLoad || _notes == null) {
      final notes = await notesClient.getNotes('');
      _notes = notes;
    }
    return _notes;
  }

  Future<void> saveNote(Note note) => notesClient.createNote('', note);

  Future<void> deleteNote(Note note) => notesClient.deleteNote('', note.id);
}
