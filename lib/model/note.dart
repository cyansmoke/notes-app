import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@immutable
@JsonSerializable()
class Note {
  final int id;
  final String body;
  final String title;
  @JsonKey(name: 'date_created')
  final String dateCreated;

  Note(this.body, this.dateCreated, [this.id, this.title]);

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
