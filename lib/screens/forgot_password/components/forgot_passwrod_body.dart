// ignore_for_file: unused_import, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/global_component/no_account_text.dart';
import 'package:mien_spa_mobile/screens/forgot_password/components/form_forgot_password.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ForgotPasswrodBody extends StatefulWidget {
  const ForgotPasswrodBody({Key? key}) : super(key: key);

  @override
  _ForgotPasswrodBodyState createState() => _ForgotPasswrodBodyState();
}

class _ForgotPasswrodBodyState extends State<ForgotPasswrodBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              Text(
                "Quên mật khẩu",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Vui lòng nhập email của bạn và chúng tôi sẽ gửi \nbạn một mã otp để quay lại tài khoản của bạn",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              ForgotPasswordForm(),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
