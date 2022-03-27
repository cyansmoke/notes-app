import 'package:dio/dio.dart';
import 'package:notes/api/orders/mocked_orders_client.dart';
import 'package:notes/main.dart';
import 'package:notes/model/order/order.dart';
import 'package:notes/model/order/orders.dart';
import 'package:notes/model/user.dart';
import 'package:retrofit/http.dart';

part 'orders_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  factory OrdersApiClient.mocked() => MockedOrdersApiClient();

  static const _AUTH_HEADER = 'Authorization';

  static const _GET_ORDERS_ENDPOINT = 'orders/get';
  static const _DELETE_ORDERS_ENDPOINT = 'orders/delete/{id}';
  static const _CREATE_ORDERS_ENDPOINT = 'orders/create';
  static const _UPDATE_ORDERS_ENDPOINT = 'orders/update/{id}';
  static const _COMPLETE_ORDER_ENDPOINT = 'orders/complete/{id}';

  @GET(_GET_ORDERS_ENDPOINT)
  Future<Orders> getOrders(
    @Header(_AUTH_HEADER) String authToken,
    @Body() User user,
  );

  @PUT(_UPDATE_ORDERS_ENDPOINT)
  Future<void> updateOrder(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') String id,
    @Body() Order order,
  );

  @POST(_CREATE_ORDERS_ENDPOINT)
  Future<void> createOrder(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') String id,
    @Body() Order order,
  );

  @DELETE(_DELETE_ORDERS_ENDPOINT)
  Future<void> deleteOrder(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') String id,
  );

  @PUT(_COMPLETE_ORDER_ENDPOINT)
  Future<void> completeOrder(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') String id,
  );
}
