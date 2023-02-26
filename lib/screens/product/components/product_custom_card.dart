// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_extension.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  final double width;
  final VoidCallback onTapCart;

  const CustomProductCard({
    Key? key,
    required this.product,
    required this.width,
    required this.onTapCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> likeButtonTapped(bool isLiked) async {
      return !isLiked;
    }

    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
      ),
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(20),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LikeButton(
                onTap: likeButtonTapped,
                size: 24,
                animationDuration: Duration(milliseconds: 500),
                bubblesSize: 100,
              )
            ],
          ),
          Container(
            width: getProportionateScreenHeight(160),
            height: getProportionateScreenWidth(120),
            margin: EdgeInsets.all(5),
            child: ImageContainer(
              borderRadius: 10,
              width: width,
              imageUrl:
                  ApiUrl.localhost + "/image/product/" + product.featureImgPath,
              boxfit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              product.proName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              product.proContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: RatingBarIndicator(
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              rating: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.dotPrice(),
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //       shape: StadiumBorder(), backgroundColor: KPrimaryColor),
                //   onPressed: () {
                //     onTapCart;
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     // ignore: prefer_const_literals_to_create_immutables
                //     children: [
                //       Icon(
                //         Icons.shopping_cart_checkout_outlined,
                //         size: 18,
                //       ),
                //       Text("Thêm giỏ hàng")
                //     ],
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
