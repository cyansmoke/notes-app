import 'package:retrofit/http.dart';

import '../../main.dart';

@RestApi(baseUrl: BASE_URL)
abstract class CourierApiClient {
  static const _COURIER_ENDPOINT = 'api/courier/';
  static const _NOTES_WITH_ID_ENDPOINT = '$_COURIER_ENDPOINT{id}';
  static const _AUTH_HEADER = 'Authorization';

  factory CourierApiClient(Dio dio, {String baseUrl}) = _CourierApiClient;

  @GET(_COURIER_ENDPOINT)
  Future<Notes> getNotes(@Header(_AUTH_HEADER) String authToken);

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

  @POST(_COURIER_ENDPOINT)
  Future<void> createNote(
    @Header(_AUTH_HEADER) String authToken,
    @Body() Note note,
  );

  @DELETE(_NOTES_WITH_ID_ENDPOINT)
  Future<void> deleteNote(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') int id,
  );
}
