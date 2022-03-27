// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as String,
    json['address'] as String,
    json['phoneNumber'] as String,
    json['isDone'] as bool,
    json['clientId'] as int,
    json['createdTime'],
    json['supposedTimePeriod'],
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'isDone': instance.isDone,
      'clientId': instance.clientId,
      'createdTime': instance.createdTime,
      'supposedTimePeriod': instance.supposedTimePeriod,
    };
