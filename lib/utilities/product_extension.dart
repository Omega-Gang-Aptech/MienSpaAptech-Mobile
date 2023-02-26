// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:mien_spa_mobile/dto/response/product_response.dart';

extension ProductPriceExtension on Product {
  String dotPrice() {
    if (proPrice.toString().length <= 12 && proPrice.toString().length >= 10) {
      return proPrice.toString().substring(0, proPrice.toString().length - 9) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 9, proPrice.toString().length - 6) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 6, proPrice.toString().length - 3) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 3, proPrice.toString().length) +
          " VND";
    }
    if (proPrice.toString().length <= 9 && proPrice.toString().length >= 7) {
      return proPrice.toString().substring(0, proPrice.toString().length - 6) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 6, proPrice.toString().length - 3) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 3, proPrice.toString().length) +
          " VND";
    }
    if (proPrice.toString().length <= 6 && proPrice.toString().length >= 4) {
      return proPrice.toString().substring(0, proPrice.toString().length - 3) +
          "." +
          proPrice.toString().substring(
              proPrice.toString().length - 3, proPrice.toString().length) +
          " VND";
    }
    if (proPrice.toString().length <= 3 && proPrice.toString().length >= 0) {
      return proPrice.toString() + " VND";
    } else {
      return "Liên hệ ";
    }
  }
}
