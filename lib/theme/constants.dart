// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mien_spa_mobile/config/size_config.dart';

dynamic KPrimaryColor = HexColor("#fd3d9b");
dynamic KWhite = HexColor("ffffff");
dynamic KBlack = HexColor("#0000");
dynamic KBlue = HexColor("#001BFF").withOpacity(0.8);
dynamic KLightBlue = HexColor("#001BFF").withOpacity(0.1);
dynamic KGray = HexColor("#999999");
dynamic KRed = HexColor("#fc0000");
dynamic KLightPink = HexColor("#FFF5F6F9");
dynamic KGrey200 = HexColor("#eeeeee").withOpacity(1);
dynamic KGreeen = HexColor("#6aa84f");
dynamic KLightWhite = HexColor("#FFFF5F6F9");
const KAnimationDuration = Duration(milliseconds: 200);

final OtpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenHeight(15),
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: KPrimaryColor),
  );
}
