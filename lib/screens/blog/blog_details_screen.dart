// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/global_component/hero_image.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';
import 'package:mien_spa_mobile/models/blog_articles.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

import 'package:mien_spa_mobile/global_component/custom_tag.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({Key? key}) : super(key: key);
  static String routeName = '/blog_details_screen';

  @override
  _BlogDetailsScreenState createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    return Scaffold(
      backgroundColor: KWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              HeroImage(
                tag: article.articleImageUrl,
                launchPhoto: article.articleImageUrl,
                child: ImageContainer(
                  imageUrl: article.articleImageUrl,
                  width: double.infinity,
                  height: 200,
                  borderRadius: 0,
                  boxfit: BoxFit.cover,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 56, left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: KWhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      article.articleTitle,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        article.articleSubtitle,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTag(
                        backgroundColor: KPrimaryColor,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                              article.articleAuthorImageUrl,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            article.articleAuthor,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      CustomTag(backgroundColor: KPrimaryColor, children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            if (article.createdAt.isAfter(
                              DateTime.now().subtract(
                                Duration(
                                  hours: 24,
                                ),
                              ),
                            )) ...[
                              Text(
                                '${DateTime.now().difference(article.createdAt).inHours} tiếng trước',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ] else ...[
                              Text(
                                '${DateTime.now().difference(article.createdAt).inDays} ngày trước',
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ],
                        ),
                      ]),
                      CustomTag(backgroundColor: KPrimaryColor, children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility,
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${article.articleViews} lượt xem',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ])
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    article.articleBody,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(6),
                      itemCount: article.articleArrayImageUrl.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 1.25,
                      ),
                      itemBuilder: (context, index) {
                        return HeroImage(
                          tag: article.articleArrayImageUrl[index],
                          launchPhoto: article.articleArrayImageUrl[index],
                          child: ImageContainer(
                              borderRadius: 10,
                              width: MediaQuery.of(context).size.width * 0.42,
                              imageUrl: article.articleArrayImageUrl[index],
                              boxfit: BoxFit.cover),
                        );
                      }),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
