// To parse this JSON data, do
//
//     final serce = serceFromJson(jsonString);

import 'dart:convert';

List<Serce> serceFromJson(String str) =>
    List<Serce>.from(json.decode(str).map((x) => Serce.fromJson(x)));

String serceToJson(List<Serce> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Serce {
  Serce({
    required this.createdAt,
    this.updatedAt,
    required this.seId,
    required this.seName,
    required this.sePrice,
    required this.seDescription,
    required this.seNote,
    required this.seImage,
    required this.seTurnOn,
    required this.isDelete,
  });

  DateTime createdAt;
  DateTime? updatedAt;
  String seId;
  String seName;
  int sePrice;
  String seDescription;
  String seNote;
  String seImage;
  bool seTurnOn;
  bool isDelete;

  factory Serce.fromJson(Map<String, dynamic> json) => Serce(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        seId: json["seId"],
        seName: json["seName"],
        sePrice: json["sePrice"],
        seDescription: json["seDescription"],
        seNote: json["seNote"],
        seImage: json["seImage"],
        seTurnOn: json["seTurnOn"],
        isDelete: json["isDelete"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "seId": seId,
        "seName": seName,
        "sePrice": sePrice,
        "seDescription": seDescription,
        "seNote": seNote,
        "seImage": seImage,
        "seTurnOn": seTurnOn,
        "isDelete": isDelete,
      };
}
