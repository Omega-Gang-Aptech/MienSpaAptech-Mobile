import 'dart:convert';

List<CartProductList> cartProductListFromJson(String str) =>
    List<CartProductList>.from(
        json.decode(str).map((x) => CartProductList.fromJson(x)));

String cartProductListToJson(List<CartProductList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartProductList {
  CartProductList({
    required this.ordProQuantity,
    required this.productId,
  });

  int ordProQuantity;
  String productId;

  factory CartProductList.fromJson(Map<String, dynamic> json) =>
      CartProductList(
        ordProQuantity: json["ordProQuantity"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "ordProQuantity": ordProQuantity,
        "productId": productId,
      };
}
