// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/login_success/components/login_success_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Đăng nhập thành công",
          style: GoogleFonts.lora(
            textStyle: Theme.of(context).textTheme.headline4,
            color: KWhite,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: SizedBox(),
        backgroundColor: KPrimaryColor,
      ),
      body: LoginSuccessBody(),
    );
  }
}
