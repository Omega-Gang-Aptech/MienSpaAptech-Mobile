// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/serce_extension.dart';

import 'package:mien_spa_mobile/dto/response/serce_response.dart';

class CustomSerceCard extends StatelessWidget {
  final Serce serce;
  final double width;
  // final VoidCallback onTapCart;

  const CustomSerceCard({
    Key? key,
    required this.serce,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              ApiUrl.localhost + "/image/service/" + serce.seImage),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          width: 1,
          color: KPrimaryColor,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),

        borderRadius: BorderRadius.circular(20),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: KPrimaryColor,
            blurRadius: 5.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: KPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                serce.dotPrice(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: KWhite,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: KPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                serce.seName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: KWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
