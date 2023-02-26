import 'package:mien_spa_mobile/dto/response/category_response.dart';
import 'package:mien_spa_mobile/services/category_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_categories.g.dart';

@riverpod
Future<List<Category>> filterCategories(FilterCategoriesRef ref) async {
  var allCategories =
      await ref.watch(categoryServiceProvider).getAllCategories();
  return Future.delayed(
    const Duration(milliseconds: 500),
    () {
      return allCategories;
    },
  );
}
