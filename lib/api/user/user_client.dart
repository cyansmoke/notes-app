import 'package:dio/dio.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/order/orders.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';
import 'package:retrofit/http.dart';
import 'package:notes/api/user/mocked_user_client.dart';

import '../../main.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  factory UserApiClient.mocked() => MockedUserApiClient();

  static const _SIGN_UP_ENDPOINT = 'auth/sign-up';
  static const _SIGN_IN_ENDPOINT = 'auth/sign-in';
  static const _USER_ENDPOINT = 'api/user/';

  static const _MAKE_ORDER_ENDPOINT = 'orders/make';
  static const _GET_ORDERS_ENDPOINT = 'orders/get';

  static const _AUTH_HEADER = 'Authorization';

  @POST(_SIGN_IN_ENDPOINT)
  Future<Token> signIn(@Body() User user);

  @POST(_SIGN_UP_ENDPOINT)
  Future<Token> signUp(@Body() User user);

  @GET(_USER_ENDPOINT)
  Future<User> getUser(@Header(_AUTH_HEADER) String authToken);

  @GET(_GET_ORDERS_ENDPOINT)
  Future<Orders> getOrders(@Header(_AUTH_HEADER) String authToken);

  @GET(_MAKE_ORDER_ENDPOINT)
  Future<Order> createOrder(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') int id,
  );
}
