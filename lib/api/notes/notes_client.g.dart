// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NotesApiClient implements NotesApiClient {
  _NotesApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://stormy-woodland-10710.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Notes> getNotes(authToken) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/notes',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Notes.fromJson(_result.data);
    return value;
  }

  @override
  Future<Note> getNote(authToken, id) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/notes/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Note.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> updateNote(authToken, id, note) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(note, 'note');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(note?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    await _dio.request<void>('api/notes/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<void> createNote(authToken, note) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(note, 'note');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(note?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    await _dio.request<void>('api/notes',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<void> deleteNote(authToken, id) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('api/notes/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }
}
