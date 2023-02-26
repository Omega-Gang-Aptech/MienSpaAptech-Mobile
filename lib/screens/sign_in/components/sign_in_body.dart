// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_string_interpolations, non_constant_identifier_names, body_might_complete_normally_nullable, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/no_account_text.dart';
import 'package:mien_spa_mobile/global_component/socal_card.dart';
import 'package:mien_spa_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/components/sign_in_form.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Chào mừng trở lại",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Đăng nhập bằng email và mật khẩu của bạn \nhoặc tiếp tục với phương tiện truyền thông xã hội",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      press: () {},
                    ),
                    SocalCard(
                      icon: FaIcon(FontAwesomeIcons.google),
                      press: () {},
                    ),
                    SocalCard(
                      icon: FaIcon(FontAwesomeIcons.twitter),
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                NoAccountText(),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName),
                    child: Text(
                      "Quên mật khẩu >>",
                      style: GoogleFonts.roboto(
                        decoration: TextDecoration.underline,
                        color: KPrimaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
