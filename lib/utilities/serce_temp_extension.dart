// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:mien_spa_mobile/dto/response/serce_response.dart';
import 'package:mien_spa_mobile/dto/response/serce_response_temp.dart';

extension SercePriceExtension on SerceTemp {
  String dotPrice() {
    if (sePrice.toString().length <= 12 && sePrice.toString().length >= 10) {
      return sePrice.toString().substring(0, sePrice.toString().length - 9) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 9, sePrice.toString().length - 6) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 6, sePrice.toString().length - 3) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 3, sePrice.toString().length) +
          " VND";
    }
    if (sePrice.toString().length <= 9 && sePrice.toString().length >= 7) {
      return sePrice.toString().substring(0, sePrice.toString().length - 6) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 6, sePrice.toString().length - 3) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 3, sePrice.toString().length) +
          " VND";
    }
    if (sePrice.toString().length <= 6 && sePrice.toString().length >= 4) {
      return sePrice.toString().substring(0, sePrice.toString().length - 3) +
          "." +
          sePrice.toString().substring(
              sePrice.toString().length - 3, sePrice.toString().length) +
          " VND";
    }
    if (sePrice.toString().length <= 3 && sePrice.toString().length >= 0) {
      return sePrice.toString() + " VND";
    } else {
      return "Liên hệ ";
    }
  }
}
