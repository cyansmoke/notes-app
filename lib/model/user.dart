import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String login;
  String email;
  final int id;
  String phoneNumber;
  String address;
  final String password;

  User.courier()
      : id = 0,
        login = '',
        password = '';

  User(
    this.id,
    this.login,
    this.password, [
    this.email,
    this.phoneNumber,
    this.address,
  ]);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
