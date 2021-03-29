import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../main.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;
}
