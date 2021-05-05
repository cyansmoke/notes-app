import 'package:dio/dio.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';
import 'package:retrofit/http.dart';

import '../../main.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  static const _SIGN_UP_ENDPOINT = 'auth/sign-up';
  static const _SIGN_IN_ENDPOINT = 'auth/sign-in';
  static const _USER_ENDPOINT = 'api/user/';

  static const _AUTH_HEADER = 'Authorization';

  @POST(_SIGN_IN_ENDPOINT)
  Future<Token> signIn(@Body() User user);

  @POST(_SIGN_UP_ENDPOINT)
  Future<Token> signUp(@Body() User user);

  @GET(_USER_ENDPOINT)
  Future<User> getUser(@Header(_AUTH_HEADER) String authToken);

  @PUT(_USER_ENDPOINT)
  Future<void> updateUser(
    @Header(_AUTH_HEADER) String authToken,
    @Body() User user,
  );

  @DELETE(_USER_ENDPOINT)
  Future<void> deleteUser(@Header(_AUTH_HEADER) String authToken);
}
