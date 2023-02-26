// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address/components/search_and_select_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SearchAndSelectScreen extends StatefulWidget {
  const SearchAndSelectScreen({Key? key}) : super(key: key);
  static String routeName = '/search_and_select';
  @override
  _SearchAndSelectScreenState createState() => _SearchAndSelectScreenState();
}

class _SearchAndSelectScreenState extends State<SearchAndSelectScreen> {
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
        child: SearchAndSelectBody(),
      ),
    );
  }
}
