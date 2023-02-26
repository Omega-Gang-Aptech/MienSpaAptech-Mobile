// ignore_for_file: unrelated_type_equality_checks

import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/services/product_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'getall_product_provider.g.dart';

@riverpod
Future<List<Product>> getAllProduct(GetAllProductRef ref) async {
  var getallProducts = await ref.watch(productServiceProvider).getAllProducts();
  return Future.delayed(
    const Duration(milliseconds: 400),
    () {
      return getallProducts;
    },
  );
}
