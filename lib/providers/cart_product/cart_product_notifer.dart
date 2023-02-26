// ignore_for_file: prefer_const_constructors, unnecessary_new, depend_on_referenced_packages, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/dto/response/product_response.dart';

import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:collection/collection.dart';

final cartNotifierProvider = ChangeNotifierProvider.autoDispose<CartNotifier>(
  (ref) => CartNotifier(),
);

class CartNotifier extends ChangeNotifier {
  List<CartProduct> _cart = [];
  final storage = new FlutterSecureStorage();

  Future<bool> addProduct(CartProduct product) async {
    int sum = 0;
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        _cart.add(dataCart);
      }
    }
    var checkProduct = _cart
        .firstWhereOrNull((element) => element.productId == product.productId);
    if (checkProduct == null) {
      _cart.add(product);
    } else {
      if (checkProduct.ordProQuantity + product.ordProQuantity < 11) {
        _cart.remove(checkProduct);
        checkProduct.ordProQuantity =
            checkProduct.ordProQuantity + product.ordProQuantity;
        _cart.add(checkProduct);
      } else {
        return false;
      }
    }
    var data = await ApiClient().get("/api/Product").catchError((err) {});
    if (data != null) {
      List<Product> listProduct = productFromJson(data);
      for (var element in listProduct) {
        for (var item in _cart) {
          if (element.proId == item.productId) {
            sum = sum + (element.proPrice * item.ordProQuantity);
          }
        }
      }
    }
    await storage.write(key: "total", value: sum.toString());
    await storage.write(key: "cart", value: json.encode(_cart.toList()));
    return true;
  }

  void removeProduct(CartProduct product) async {
    int sum = 0;
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        _cart.add(dataCart);
      }
    }
    _cart.removeWhere((c) => c.productId == product.productId);
    var data = await ApiClient().get("/api/Product").catchError((err) {});
    if (data != null) {
      List<Product> listProduct = productFromJson(data);
      for (var element in listProduct) {
        for (var item in _cart) {
          if (element.proId == item.productId) {
            sum = sum + (element.proPrice * item.ordProQuantity);
          }
        }
      }
    }
    await storage.write(key: "total", value: sum.toString());
    await storage.write(key: "cart", value: json.encode(_cart.toList()));
  }

  Future<void> updateProduct(CartProduct product) async {
    int sum = 0;
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart;
        if (element.productId == product.productId) {
          dataCart = CartProduct(
              ordProQuantity: product.ordProQuantity,
              productId: element.productId);
        } else {
          dataCart = CartProduct(
              ordProQuantity: element.ordProQuantity,
              productId: element.productId);
        }
        _cart.add(dataCart);
      }
    }
    var listData = await ApiClient().get("/api/Product").catchError((err) {});
    if (listData != null) {
      List<Product> listProduct = productFromJson(listData);
      for (var element in listProduct) {
        for (var item in _cart) {
          if (element.proId == item.productId) {
            sum = sum + (element.proPrice * item.ordProQuantity);
          }
        }
      }
      await storage.write(key: "total", value: sum.toString());
    }
    await storage.write(key: "cart", value: json.encode(_cart.toList()));
  }

  Future<dynamic> getCount() async {
    var b = await storage.read(key: "total");
    if (b != null) {
      return b.toString();
    } else {
      return null;
    }
  }
}
