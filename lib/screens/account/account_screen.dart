// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/account/components/account_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static String routeName = '/account_screen';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Cài đặt tài khoản",
            style: GoogleFonts.lora(
              textStyle: Theme.of(context).textTheme.headline4,
              color: KBlack,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
        backgroundColor: KWhite,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: KBlack,
        ),
      ),
      body: AccountBody(),
    );
  }
}
