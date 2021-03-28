import 'dart:async';

import 'package:dio/dio.dart';
import 'package:notes/model/note.dart';
import 'package:retrofit/http.dart';

import '../../main.dart';

part 'notes_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class NotesClient {
  static const _NOTES_ENDPOINT = '/notes';
  static const _NOTES_WITH_ID_ENDPOINT = '/notes/{id}';
  static const _AUTH_HEADER = 'Authentication';

  factory NotesClient(Dio dio, {String baseUrl}) = _NotesClient;

  @GET(_NOTES_ENDPOINT)
  Future<List<Note>> getNotes(@Header(_AUTH_HEADER) String authToken);

  @GET(_NOTES_WITH_ID_ENDPOINT)
  Future<Note> getNote(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') int id,
  );

  @PUT(_NOTES_WITH_ID_ENDPOINT)
  Future<void> updateNote(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') int id,
    @Body() Note note,
  );

  @POST(_NOTES_ENDPOINT)
  Future<void> createNote(
    @Header(_AUTH_HEADER) String authToken,
    @Body() Note note,
  );

  @DELETE(_NOTES_WITH_ID_ENDPOINT)
  Future<void> deleteNote(
    @Header(_AUTH_HEADER) String authToken,
  );
}
