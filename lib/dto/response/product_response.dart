import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.createdAt,
    this.updatedAt,
    required this.proId,
    required this.categoryId,
    required this.proName,
    required this.proPrice,
    required this.featureImgPath,
    required this.proContent,
    required this.proBrand,
    required this.proTurnOn,
    required this.isDelete,
  });

  DateTime createdAt;
  DateTime? updatedAt;
  String proId;
  int categoryId;
  String proName;
  int proPrice;
  String featureImgPath;
  String proContent;
  String proBrand;
  bool proTurnOn;
  bool isDelete;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        proId: json["proId"],
        categoryId: json["category_id"],
        proName: json["proName"],
        proPrice: json["proPrice"],
        featureImgPath: json["featureImgPath"],
        proContent: json["proContent"],
        proBrand: json["proBrand"],
        proTurnOn: json["proTurnOn"],
        isDelete: json["isDelete"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "proId": proId,
        "category_id": categoryId,
        "proName": proName,
        "proPrice": proPrice,
        "featureImgPath": featureImgPath,
        "proContent": proContent,
        "proBrand": proBrand,
        "proTurnOn": proTurnOn,
        "isDelete": isDelete,
      };
}
