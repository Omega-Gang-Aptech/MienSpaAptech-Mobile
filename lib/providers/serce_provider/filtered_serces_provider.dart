// ignore_for_file: unrelated_type_equality_checks

import 'package:mien_spa_mobile/services/serce_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mien_spa_mobile/dto/response/serce_response.dart';

part 'filtered_serces_provider.g.dart';

@riverpod
Future<List<Serce>> filteredSercesAll(FilteredSercesAllRef ref) async {
  var allSerces = await ref.watch(serceServiceProvider).getAllSerces();
  allSerces = allSerces.where((element) => element.isDelete == false).toList();
  return Future.delayed(
    const Duration(milliseconds: 400),
    () {
      return allSerces;
    },
  );
}
