import 'dart:convert';

List<Category> welcomeFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String welcomeToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.createdAt,
    this.updatedAt,
    required this.cateId,
    required this.cateName,
    required this.cateIdParent,
    required this.isDelete,
  });

  DateTime createdAt;
  DateTime? updatedAt;
  int cateId;
  String cateName;
  int cateIdParent;
  bool isDelete;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        cateId: json["cateId"],
        cateName: json["cateName"],
        cateIdParent: json["cateIdParent"],
        isDelete: json["isDelete"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "cateId": cateId,
        "cateName": cateName,
        "cateIdParent": cateIdParent,
        "isDelete": isDelete,
      };
}
