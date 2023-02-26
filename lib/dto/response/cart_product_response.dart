// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

CartProductResponse productResponseFromJson(String str) =>
    CartProductResponse.fromJson(json.decode(str));

String productResponseToJson(CartProductResponse data) =>
    json.encode(data.toJson());

class CartProductResponse {
  CartProductResponse({
    this.categoryId,
    this.createdAt,
    this.featureImgPath,
    this.isDelete,
    this.proBrand,
    this.proContent,
    this.proId,
    this.proName,
    this.proPrice,
    this.proTurnOn,
    this.updatedAt,
  });

  int? categoryId;
  dynamic? createdAt;
  String? featureImgPath;
  bool? isDelete;
  String? proBrand;
  String? proContent;
  String? proId;
  String? proName;
  int? proPrice;
  bool? proTurnOn;
  dynamic? updatedAt;

  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      CartProductResponse(
        categoryId: json["category_id"],
        createdAt: json["createdAt"],
        featureImgPath: json["featureImgPath"],
        isDelete: json["isDelete"],
        proBrand: json["proBrand"],
        proContent: json["proContent"],
        proId: json["proId"],
        proName: json["proName"],
        proPrice: json["proPrice"],
        proTurnOn: json["proTurnOn"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "createdAt":
            createdAt.toString() == "null" ? null : createdAt.toString(),
        "featureImgPath": featureImgPath,
        "isDelete": isDelete,
        "proBrand": proBrand,
        "proContent": proContent,
        "proId": proId,
        "proName": proName,
        "proPrice": proPrice,
        "proTurnOn": proTurnOn,
        "updatedAt":
            updatedAt.toString() == "null" ? null : updatedAt.toString(),
      };
}
