// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    title: json['title'] as String,
    description: json['description'] as String,
    id: json['id'] as String,
    address: json['address'] as String,
    phoneNumber: json['phoneNumber'] as String,
    isDone: json['isDone'] as bool,
    clientId: json['clientId'] as int,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    supposedTimePeriod:
        _$enumDecodeNullable(_$TimePeriodEnumMap, json['supposedTimePeriod']),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'id': instance.id,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'isDone': instance.isDone,
      'clientId': instance.clientId,
      'createdTime': instance.createdTime?.toIso8601String(),
      'supposedTimePeriod': _$TimePeriodEnumMap[instance.supposedTimePeriod],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TimePeriodEnumMap = {
  TimePeriod.morning: 'morning',
  TimePeriod.day: 'day',
  TimePeriod.night: 'night',
};
