// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address_order/components/search_and_select_address_order_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SearchAndSelectAddressOrderScreen extends StatelessWidget {
  const SearchAndSelectAddressOrderScreen({Key? key}) : super(key: key);
  static String routeName = '/search_and_select_order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Địa chỉ",
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: KPrimaryColor,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SearchAndSelectAddressOrderBody(),
      ),
    );
  }
}
