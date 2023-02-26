// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/screens/change_password/components/change_password_form.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  _ChangePasswordBodyState createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
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
                "Đổi mật khẩu",
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
              ChangePasswordForm(),
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
