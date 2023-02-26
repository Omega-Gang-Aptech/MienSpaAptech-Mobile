import 'dart:convert';

import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mien_spa_mobile/dto/response/serce_response.dart';
part 'serce_service.g.dart';

@riverpod
SerceService serceService(SerceServiceRef ref) => SerceService();

class SerceService {
  Future<List<Serce>> getAllSerces() async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        var data = await ApiClient().get("/api/Serce").catchError((err) {});
        if (data != null) {
          final List result = jsonDecode(data);
          return result.map((e) => Serce.fromJson(e)).toList();
        } else {
          throw Exception("");
        }
      },
    );
  }
}
