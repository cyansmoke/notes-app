// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    json['body'] as String,
    json['title'] as String,
    json['id'] as int,
    json['date_created'] as String,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
      'date_created': instance.dateCreated,
    };
