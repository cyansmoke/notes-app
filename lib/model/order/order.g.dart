// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['address'] as String,
    json['latLng'] == null
        ? null
        : LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
    json['phoneNumber'] as String,
    json['isDone'] as bool,
    json['clientId'] as int,
    json['createdTime'],
    json['supposedTimePeriod'],
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'address': instance.address,
      'latLng': instance.latLng?.toJson(),
      'phoneNumber': instance.phoneNumber,
      'isDone': instance.isDone,
      'clientId': instance.clientId,
      'createdTime': instance.createdTime,
      'supposedTimePeriod': instance.supposedTimePeriod,
    };
