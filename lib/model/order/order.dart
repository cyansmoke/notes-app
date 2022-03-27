import 'package:json_annotation/json_annotation.dart';

import '../latlng.dart';

part 'order.g.dart';

enum TimePeriod { morning, day, night }

@JsonSerializable(explicitToJson: true)
class Order {
  String id;
  final String address;
  final String phoneNumber;
  bool isDone;
  int clientId;
  final createdTime;
  final supposedTimePeriod;

  Order(
    this.id,
    this.address,
    this.phoneNumber,
    this.isDone,
    this.clientId,
    this.createdTime,
    this.supposedTimePeriod,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
