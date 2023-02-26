import 'package:mien_spa_mobile/dto/response/order_product_response.dart';
import 'package:mien_spa_mobile/services/order_product_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_order_prosuct.g.dart';

@riverpod
Future<List<OrderProductReponse>> filterOrderProduct(
    FilterOrderProductRef ref) async {
  var allOrderProductByUser =
      await ref.watch(orderProductServiceProvider).getOrderByUser();
  return Future.delayed(
    const Duration(milliseconds: 800),
    () {
      return allOrderProductByUser;
    },
  );
}
