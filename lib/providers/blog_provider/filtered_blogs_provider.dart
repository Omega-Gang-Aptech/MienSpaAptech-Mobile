import 'package:mien_spa_mobile/models/blog_articles.dart';
import 'package:mien_spa_mobile/providers/blog_provider/search_blog_query_provider.dart';

import 'package:mien_spa_mobile/repositories/blog_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_blogs_provider.g.dart';

@riverpod
Future<List<Article>> filteredBlogs(FilteredBlogsRef ref) async {
  final BlogRepository blogRepository = ref.watch(blogRepositoryProvider);
  final searchBlogQuery = ref.watch(searchBlogProvider);
  var allArticle = await blogRepository.getAllArticles();

  return Future.delayed(
    const Duration(milliseconds: 500),
    () {
      if (searchBlogQuery.trim().isNotEmpty) {
        return allArticle.where((article) {
          return article.articleAuthor
                  .toLowerCase()
                  .contains(searchBlogQuery.toLowerCase()) ||
              article.articleBody
                  .toLowerCase()
                  .contains(searchBlogQuery.toLowerCase()) ||
              article.articleSubtitle
                  .toLowerCase()
                  .contains(searchBlogQuery.toLowerCase()) ||
              article.articleTitle
                  .toLowerCase()
                  .contains(searchBlogQuery.toLowerCase()) ||
              article.articleCategory
                  .toLowerCase()
                  .contains(searchBlogQuery.toLowerCase());
        }).toList();
      }

      return allArticle;
    },
  );
}
