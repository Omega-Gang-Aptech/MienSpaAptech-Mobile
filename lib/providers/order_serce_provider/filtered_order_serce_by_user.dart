import 'package:mien_spa_mobile/dto/response/order_serce_response.dart';
import 'package:mien_spa_mobile/services/order_serce_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filtered_order_serce_by_user.g.dart';

@riverpod
Future<List<OrderSerceResponse>> filteredOrderSerceResponse(
    FilteredOrderSerceResponseRef ref) async {
  var allOrderSerceByUser =
      await ref.watch(orderSerceServiceProvider).getOrderSerceByUser();
  return Future.delayed(
    const Duration(milliseconds: 500),
    () {
      return allOrderSerceByUser;
    },
  );
}
