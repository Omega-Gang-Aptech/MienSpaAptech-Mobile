import 'package:mien_spa_mobile/dto/response/category_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_category_provider.g.dart';

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  Category? build() {
    return null;
  }

  void setSelectedCategory(Category? selectedCategory) async {
    if (state == selectedCategory) {
      state == null;
    } else {
      state = selectedCategory;
    }
  }
}
