import 'package:mien_spa_mobile/models/blog_articles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blog_repository.g.dart';

@riverpod
BlogRepository blogRepository(BlogRepositoryRef ref) => BlogRepository();

class BlogRepository {
  Future<List<Article>> getAllArticles() async {
    return Future.delayed(
      const Duration(milliseconds: 700),
      () {
        return Article.articles;
      },
    );
  }

  Future<Article> getArticle(String articleId) async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        return Article.articles
            .where((article) => article.articleId == articleId)
            .first;
      },
    );
  }
}
