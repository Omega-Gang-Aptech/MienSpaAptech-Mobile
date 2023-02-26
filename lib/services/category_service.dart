import 'dart:convert';
import 'package:mien_spa_mobile/dto/response/category_response.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_service.g.dart';

@riverpod
CategoryService categoryService(CategoryServiceRef ref) => CategoryService();

class CategoryService {
  Future<List<Category>> getAllCategories() async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        var data = await ApiClient().get("/api/Category").catchError((err) {});
        if (data != null) {
          final List result = jsonDecode(data);
          return result.map((e) => Category.fromJson(e)).toList();
        } else {
          throw Exception("");
        }
      },
    );
  }
}

// class ProductService {
//   String url = "http://192.168.1.135:8181/api/Product";
//   Future<List<Product>> getAllProducts() async {
//     return Future.delayed(
//       const Duration(milliseconds: 500),
//       () async {
//         Response data = await get(Uri.parse(url));
//         if (data.statusCode == 200) {
//           final List result = jsonDecode(utf8.decode(data.bodyBytes));
//           return result.map((e) => Product.fromJson(e)).toList();
//         } else {
//           throw Exception(data.reasonPhrase);
//         }
//       },
//     );
//   }
// }
