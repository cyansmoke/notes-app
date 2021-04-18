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

  @POST(_SIGN_IN_ENDPOINT)
  Future<Token> signIn(@Body() User user);

  @POST(_SIGN_UP_ENDPOINT)
  Future<Token> signUp(@Body() User user);
}
