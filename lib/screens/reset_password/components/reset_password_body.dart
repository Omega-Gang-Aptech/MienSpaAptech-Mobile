// ignore_for_file: unused_import, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/global_component/no_account_text.dart';
import 'package:mien_spa_mobile/screens/reset_password/components/reset_password_form.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ResetPasswrodBody extends StatefulWidget {
  const ResetPasswrodBody({Key? key}) : super(key: key);

  @override
  _ResetPasswrodBodyState createState() => _ResetPasswrodBodyState();
}

class _ResetPasswrodBodyState extends State<ResetPasswrodBody> {
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
                "Đặt lại mật khẩu",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Vui lòng nhập mật khẩu mới của bạn",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              ResetPasswordForm(),
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
