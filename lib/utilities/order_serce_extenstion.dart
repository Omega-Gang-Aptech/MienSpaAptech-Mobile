// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:mien_spa_mobile/dto/response/cart_product_response.dart';
import 'package:mien_spa_mobile/dto/response/order_serce_response.dart';

extension OrderSerceTotalExtension on OrderSerceResponse {
  String dotPrice() {
    if (orSerTotal.toString().length <= 12 &&
        orSerTotal.toString().length >= 10) {
      return orSerTotal
              .toString()
              .substring(0, orSerTotal.toString().length - 9) +
          "." +
          orSerTotal.toString().substring(orSerTotal.toString().length - 9,
              orSerTotal.toString().length - 6) +
          "." +
          orSerTotal.toString().substring(orSerTotal.toString().length - 6,
              orSerTotal.toString().length - 3) +
          "." +
          orSerTotal.toString().substring(
              orSerTotal.toString().length - 3, orSerTotal.toString().length) +
          " VND";
    }
    if (orSerTotal.toString().length <= 9 &&
        orSerTotal.toString().length >= 7) {
      return orSerTotal
              .toString()
              .substring(0, orSerTotal.toString().length - 6) +
          "." +
          orSerTotal.toString().substring(orSerTotal.toString().length - 6,
              orSerTotal.toString().length - 3) +
          "." +
          orSerTotal.toString().substring(
              orSerTotal.toString().length - 3, orSerTotal.toString().length) +
          " VND";
    }
    if (orSerTotal.toString().length <= 6 &&
        orSerTotal.toString().length >= 4) {
      return orSerTotal
              .toString()
              .substring(0, orSerTotal.toString().length - 3) +
          "." +
          orSerTotal.toString().substring(
              orSerTotal.toString().length - 3, orSerTotal.toString().length) +
          " VND";
    }
    if (orSerTotal.toString().length <= 3 &&
        orSerTotal.toString().length >= 0) {
      return orSerTotal.toString() + " VND";
    } else {
      return "Liên hệ ";
    }
  }
}
