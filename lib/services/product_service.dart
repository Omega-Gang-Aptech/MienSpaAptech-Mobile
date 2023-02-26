import 'dart:convert';

import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_service.g.dart';

@riverpod
ProductService productService(ProductServiceRef ref) => ProductService();

class ProductService {
  Future<List<Product>> getAllProducts() async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        var data = await ApiClient().get("/api/Product").catchError((err) {});
        if (data != null) {
          final List result = jsonDecode(data);
          return result.map((e) => Product.fromJson(e)).toList();
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
