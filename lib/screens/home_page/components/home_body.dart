// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last, library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';

import 'package:mien_spa_mobile/screens/home_page/components/home_carousel.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_content.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_footer.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_product.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_service.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_expandable_FAB.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final Uri _urlHotLine = Uri.parse('tel:+84-869-177-683');

  Future<void> _launchUrlHotLine() async {
    if (!await launchUrl(_urlHotLine)) {
      throw 'Could not launch $_urlHotLine';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thickness: 3,
        radius: Radius.circular(100),
        child: Container(
          color: KWhite,
          child: Stack(
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  HomeContent(),
                  HomeCarousel(),
                  SizedBox(
                    height: 20,
                  ),
                  HomeService(),
                  SizedBox(
                    height: 20,
                  ),
                  HomeProduct(),
                  HomeFooter(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              HomeExpandableFAB(),
            ],
          ),
        ));
  }
}
