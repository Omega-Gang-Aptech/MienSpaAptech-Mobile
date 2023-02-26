// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/cart_product/components/cart_product_body.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class CartProductScreen extends StatelessWidget {
  const CartProductScreen({Key? key}) : super(key: key);
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          title: Column(
            children: [
              Text(
                "Giỏ hàng",
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: KWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(
                    context, MainContainer.routeName);
              }),
        ),
        body: CartProductBody(),
      ),
    );
  }
}
