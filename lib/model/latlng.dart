import 'package:json_annotation/json_annotation.dart';

part 'latlng.g.dart';

@JsonSerializable(explicitToJson: true)
class LatLng {
  const LatLng(double latitude, double longitude)
      : assert(latitude != null),
        assert(longitude != null),
        latitude = (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        longitude =
            longitude >= -180 && longitude < 180 ? longitude : (longitude + 180.0) % 360.0 - 180.0;

  final double latitude;

  final double longitude;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}
