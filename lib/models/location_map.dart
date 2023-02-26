import 'dart:convert';

LocationMap locationMapFromJson(String str) =>
    LocationMap.fromJson(json.decode(str));

String locationMapToJson(LocationMap data) => json.encode(data.toJson());

class LocationMap {
  LocationMap({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory LocationMap.fromJson(Map<String, dynamic> json) => LocationMap(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
