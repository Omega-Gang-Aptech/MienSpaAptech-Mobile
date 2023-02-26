import 'dart:convert';

Distance distanceFromJson(String str) => Distance.fromJson(json.decode(str));

String distanceToJson(Distance data) => json.encode(data.toJson());

class Distance {
  Distance({
    required this.text,
    required this.value,
  });

  String text;
  int value;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}
