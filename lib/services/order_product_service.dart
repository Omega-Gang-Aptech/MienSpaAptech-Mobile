// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/response/order_product_response.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'order_product_service.g.dart';

@riverpod
OrderProductService orderProductService(OrderProductServiceRef ref) =>
    OrderProductService();
final storage = new FlutterSecureStorage();
late UserRespone user;
int countLoad = 0;

class OrderProductService {
  Future<List<OrderProductReponse>> getOrderByUser() async {
    var dataUser = await storage.read(key: "api_account");
    if (dataUser != null) {
      SignInReponse convertData = signInReponseFromJson(dataUser);
      var respone = await BaseAuthorClient()
          .get('/api/Users/' + convertData.id)
          .catchError((err) {});
      if (respone != null) {
        user = userResponeFromJson(respone);
        var dataOrder = await BaseAuthorClient()
            .get("/api/OrdersPro/User/" + user.usId!)
            .catchError((err) {});
        if (dataOrder != null) {
          final List result = jsonDecode(dataOrder);
          return result.map((e) => OrderProductReponse.fromJson(e)).toList();
        } else {
          throw Exception("Error");
        }
      } else {
        if (countLoad < 4) {
          countLoad++;
          return getOrderByUser();
        } else {
          throw Exception("Error");
        }
      }
    } else {
      throw Exception("Error");
    }
  }
}
