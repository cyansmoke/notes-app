import 'package:dio/dio.dart';
import 'package:notes/model/order/orders.dart';
import 'package:retrofit/http.dart';

import '../../main.dart';
import '../../model/order/order.dart';

part "courier_client.g.dart";

@RestApi(baseUrl: BASE_URL)
abstract class CourierApiClient {
  static const _COURIER_ENDPOINT = 'api/courier/orders/';
  static const _ORDER_WITH_ID_ENDPOINT = '$_COURIER_ENDPOINT{id}/done';
  static const _AUTH_HEADER = 'Authorization';
  static const _CREATE_ORDERS_ENDPOINT = '$_COURIER_ENDPOINT{id}/map';

  factory CourierApiClient(Dio dio, {String baseUrl}) = _CourierApiClient;

  @GET(_COURIER_ENDPOINT)
  Future<Orders> getOrders(@Header(_AUTH_HEADER) String authToken);

  @GET(_ORDER_WITH_ID_ENDPOINT)
  Future<Order> markOrderAsDone(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') String id,
  );

  @GET(_CREATE_ORDERS_ENDPOINT)
  Future<Order> createOrderMap(
    @Header(_AUTH_HEADER) String authToken,
    @Path('id') int id,
  );
}
