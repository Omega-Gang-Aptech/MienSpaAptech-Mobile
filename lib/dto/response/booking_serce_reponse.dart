import 'dart:convert';

BookingSerceReponse bookingSerceReponseFromJson(String str) =>
    BookingSerceReponse.fromJson(json.decode(str));

String bookingSerceReponseToJson(BookingSerceReponse data) =>
    json.encode(data.toJson());

class BookingSerceReponse {
  BookingSerceReponse({
    this.createdAt,
    this.isDelete,
    this.seDescription,
    this.seId,
    this.seImage,
    this.seName,
    this.seNote,
    this.sePrice,
    this.seTurnOn,
    this.updatedAt,
  });

  dynamic createdAt;
  bool? isDelete;
  String? seDescription;
  String? seId;
  String? seImage;
  String? seName;
  String? seNote;
  int? sePrice;
  bool? seTurnOn;
  dynamic updatedAt;

  factory BookingSerceReponse.fromJson(Map<String, dynamic> json) =>
      BookingSerceReponse(
        createdAt: DateTime.parse(json["createdAt"]),
        isDelete: json["isDelete"],
        seDescription: json["seDescription"],
        seId: json["seId"],
        seImage: json["seImage"],
        seName: json["seName"],
        seNote: json["seNote"],
        sePrice: json["sePrice"],
        seTurnOn: json["seTurnOn"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "isDelete": isDelete,
        "seDescription": seDescription,
        "seId": seId,
        "seImage": seImage,
        "seName": seName,
        "seNote": seNote,
        "sePrice": sePrice,
        "seTurnOn": seTurnOn,
        "updatedAt": updatedAt,
      };
}
