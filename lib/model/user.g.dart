// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['login'] as String,
    json['password'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'email': instance.email,
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'password': instance.password,
    };
