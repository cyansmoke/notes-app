import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

enum TimePeriod { morning, day, night }

@JsonSerializable(explicitToJson: true)
class Order {
  final String title;
  final String description;
  String id;
  final String address;
  String phoneNumber;
  bool isDone;
  int clientId;
  final DateTime createdTime;
  final TimePeriod supposedTimePeriod;

  Order({
    this.title,
    this.description,
    this.id,
    this.address,
    this.phoneNumber,
    this.isDone,
    this.clientId,
    this.createdTime,
    this.supposedTimePeriod,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
