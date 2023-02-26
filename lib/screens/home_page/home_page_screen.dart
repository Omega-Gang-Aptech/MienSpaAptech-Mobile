// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, unnecessary_new, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  static String routeName = '/home_page_screen';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int countCart = 0;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<CartProduct> _cart = [];
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        _cart.add(dataCart);
      }
      setState(() {
        countCart = _cart.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              leadingWidth: 100,
              elevation: 0,
              backgroundColor: KPrimaryColor,
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              leading: SizedBox(
                child: Image.asset(
                  "assets/images/mien_spa_white.png",
                  fit: BoxFit.cover,
                ),
              ),
              title: Row(children: <Widget>[
                Expanded(
                    child: Text(
                  "Miên Spa",
                  style: TextStyle(color: KWhite),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: badges.Badge(
                    badgeContent: Text(
                      countCart.toString(),
                      style: TextStyle(
                        color: KRed,
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: KWhite,
                      shape: badges.BadgeShape.circle,
                      padding: EdgeInsets.all(5),
                    ),
                    badgeAnimation: badges.BadgeAnimation.scale(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pushNamed(
                            context, CartProductScreen.routeName);
                      },
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        size: 28,
                        color: KWhite,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            body: HomeBody()),
      ),
    );
  }
}
