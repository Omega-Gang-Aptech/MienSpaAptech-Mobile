// ignore_for_file: unnecessary_null_comparison

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_product_query_provider.g.dart';

@riverpod
class SearchProduct extends _$SearchProduct {
  @override
  String build() {
    return '';
  }

  void setNull() {
    state = "";
  }

  void onChange(String query) {
    if (state == query) {
      state == null;
    } else {
      state = query;
    }
  }
}
