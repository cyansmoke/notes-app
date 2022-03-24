// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CourierApiClient implements CourierApiClient {
  _CourierApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://stormy-woodland-10710.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Orders> getOrders(authToken) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/courier/orders/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Orders.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> markOrderAsDone(authToken, id) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/courier/orders/$id/done',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> createOrderMap(authToken, id) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'api/courier/orders/$id/map',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }
}
