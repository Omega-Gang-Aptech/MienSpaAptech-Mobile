// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/providers/blog_provider/filtered_blogs_provider.dart';
import 'package:mien_spa_mobile/providers/blog_provider/search_blog_query_provider.dart';
import 'package:mien_spa_mobile/screens/blog/blog_details_screen.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);
  static String routeName = '/blog_screen';

  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return WillPopScope(
      onWillPop: () async {
        await storage.write(key: "main_container_select", value: "0");
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: GestureDetector(
        onVerticalDragDown: (details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Khám phá"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: KPrimaryColor,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                // padding: const EdgeInsets.only(bottom: 20),
                children: const <Widget>[_SearchByNew(), _BlogNew()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BlogNew extends ConsumerWidget {
  const _BlogNew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(filteredBlogsProvider);
    return articles.when(
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 400),
          strokeWidth: 5,
        ),
      ),
      data: (articles) => articles.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: (() {
                          Navigator.pushNamed(
                              context, BlogDetailsScreen.routeName,
                              arguments: articles[index]);
                        }),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(100),
                              height: getProportionateScreenHeight(100),
                              child: ImageContainer(
                                boxfit: BoxFit.cover,
                                height: 100,
                                width: double.infinity,
                                margin: const EdgeInsets.all(10.0),
                                borderRadius: 5,
                                imageUrl: articles[index].articleImageUrl,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(articles[index].articleTitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      if (articles[index].createdAt.isAfter(
                                          DateTime.now().subtract(
                                              Duration(hours: 24)))) ...[
                                        Text(
                                          '${DateTime.now().difference(articles[index].createdAt).inHours} tiếng trước',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ] else ...[
                                        Text(
                                          '${DateTime.now().difference(articles[index].createdAt).inDays} ngày trước',
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                      const SizedBox(width: 20),
                                      const Icon(
                                        Icons.visibility,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${articles[index].articleViews} lượt xem',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )
          : Center(
              heightFactor: 15,
              child: Text("Không tìm thấy bài viết phù hợp từ khóa",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ),
      error: (error, stackTrace) => Center(
        child: Text(
          "Error to fetch data",
          style: TextStyle(fontSize: 18, color: KRed),
        ),
      ),
    );
  }
}

class _SearchByNew extends ConsumerWidget {
  const _SearchByNew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 16),
                hintText: 'Tìm kiếm tin tức',
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: ref.read(searchBlogProvider.notifier).onChange,
            ),
          )
        ],
      ),
    );
  }
}
