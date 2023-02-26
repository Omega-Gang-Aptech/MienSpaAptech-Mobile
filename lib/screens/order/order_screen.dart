// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/order/components/order_screen_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static String routeName = '/order';
  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, CartProductScreen.routeName);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Thanh Toán",
            style: GoogleFonts.lora(
              textStyle: Theme.of(context).textTheme.headline4,
              color: KWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(
                    context, CartProductScreen.routeName);
              }),
          backgroundColor: KPrimaryColor,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: OrderScreenBody(),
        ),
      ),
    );
  }
}
