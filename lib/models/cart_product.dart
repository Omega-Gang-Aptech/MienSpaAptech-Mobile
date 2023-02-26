import 'dart:convert';

CartProduct cartProductFromJson(String str) =>
    CartProduct.fromJson(json.decode(str));

String cartProductToJson(CartProduct data) => json.encode(data.toJson());

class CartProduct {
  CartProduct({
    required this.ordProQuantity,
    required this.productId,
  });

  int ordProQuantity;
  String productId;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        ordProQuantity: json["ordProQuantity"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "ordProQuantity": ordProQuantity,
        "productId": productId,
      };
}
