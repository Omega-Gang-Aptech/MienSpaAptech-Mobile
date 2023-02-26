import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_blog_query_provider.g.dart';

@riverpod
class SearchBlog extends _$SearchBlog {
  @override
  String build() {
    return '';
  }

  void onChange(String query) {
    state = query;
  }
}
