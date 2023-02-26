// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/on_boarding/on_boarding_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/components/sign_in_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = '/sing_in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng Nhập",
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
        child: SignInBody(),
      ),
    );
  }
}
