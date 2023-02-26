// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:mien_spa_mobile/models/total.dart';

extension ProductPriceExtension on Total {
  String dotPrice() {
    if (total.toString().length <= 12 && total.toString().length >= 10) {
      return total.toString().substring(0, total.toString().length - 9) +
          "." +
          total.toString().substring(
              total.toString().length - 9, total.toString().length - 6) +
          "." +
          total.toString().substring(
              total.toString().length - 6, total.toString().length - 3) +
          "." +
          total
              .toString()
              .substring(total.toString().length - 3, total.toString().length) +
          " VND";
    }
    if (total.toString().length <= 9 && total.toString().length >= 7) {
      return total.toString().substring(0, total.toString().length - 6) +
          "." +
          total.toString().substring(
              total.toString().length - 6, total.toString().length - 3) +
          "." +
          total
              .toString()
              .substring(total.toString().length - 3, total.toString().length) +
          " VND";
    }
    if (total.toString().length <= 6 && total.toString().length >= 4) {
      return total.toString().substring(0, total.toString().length - 3) +
          "." +
          total
              .toString()
              .substring(total.toString().length - 3, total.toString().length) +
          " VND";
    }
    if (total.toString().length <= 3 && total.toString().length >= 0) {
      return total.toString() + " VND";
    } else {
      return "Liên hệ ";
    }
  }
}
