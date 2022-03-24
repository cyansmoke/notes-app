import 'package:json_annotation/json_annotation.dart';

import '../latlng.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  final String address;
  final LatLng latLng;
  final String phoneNumber;
  final bool isDone;
  final int clientId;

  Order(this.address, this.latLng, this.phoneNumber, this.isDone, this.clientId);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
