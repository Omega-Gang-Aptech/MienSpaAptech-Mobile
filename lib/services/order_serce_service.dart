// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/response/order_serce_response.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'order_serce_service.g.dart';

@riverpod
OrderSerceService orderSerceService(OrderSerceServiceRef ref) =>
    OrderSerceService();
final storage = new FlutterSecureStorage();
late UserRespone user;
int countLoad = 0;

class OrderSerceService {
  Future<List<OrderSerceResponse>> getOrderSerceByUser() async {
    var dataUser = await storage.read(key: "api_account");

    if (dataUser != null) {
      SignInReponse convertData = signInReponseFromJson(dataUser);
      var respone = await BaseAuthorClient()
          .get('/api/Users/' + convertData.id)
          .catchError((err) {});
      if (respone != null) {
        user = userResponeFromJson(respone);
        var dataOrderSerce = await BaseAuthorClient()
            .get("/api/OrdersSer/User/" + user.usId!)
            .catchError((err) {});
        if (dataOrderSerce != null) {
          final List result = jsonDecode(dataOrderSerce);
          return result.map((e) => OrderSerceResponse.fromJson(e)).toList();
        } else {
          throw Exception("Error");
        }
      } else {
        if (countLoad < 4) {
          countLoad++;
          return getOrderSerceByUser();
        } else {
          throw Exception("Error");
        }
      }
    } else {
      throw Exception("Error");
    }
  }
}
