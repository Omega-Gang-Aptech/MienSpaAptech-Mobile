// ignore_for_file: unrelated_type_equality_checks

import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/providers/product_provider/search_product_query_provider.dart';
import 'package:mien_spa_mobile/providers/product_provider/selected_category_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mien_spa_mobile/services/product_service.dart';

part 'filtered_products_provider.g.dart';

@riverpod
Future<List<Product>> filteredProducts(FilteredProductsRef ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchProductQuery = ref.watch(searchProductProvider);
  var allProducts = await ref.watch(productServiceProvider).getAllProducts();
  allProducts =
      allProducts.where((element) => element.isDelete == false).toList();
  return Future.delayed(
    const Duration(milliseconds: 400),
    () {
      if (selectedCategory != null && searchProductQuery.trim().isNotEmpty) {
        return allProducts.where((product) {
          return product.categoryId == selectedCategory.cateId &&
              product.proName
                  .toLowerCase()
                  .contains(searchProductQuery.toLowerCase());
        }).toList();
      } else if (selectedCategory != null) {
        return allProducts.where((product) {
          return product.categoryId == selectedCategory.cateId;
        }).toList();
      } else if (searchProductQuery.trim().isNotEmpty) {
        return allProducts.where((product) {
          return product.proName
              .toLowerCase()
              .contains(searchProductQuery.toLowerCase());
        }).toList();
      }

      return allProducts;
    },
  );
}
