import 'package:json_annotation/json_annotation.dart';
import 'package:notes/model/note.dart';

part 'notes.g.dart';

@JsonSerializable(explicitToJson: true)
class Notes {
  @JsonKey(name: 'data')
  final List<Note> notes;

  factory Notes.fromJson(Map<String, dynamic> json) => _$NotesFromJson(json);

  Map<String, dynamic> toJson() => _$NotesToJson(this);

  Notes(this.notes);
}
