// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, annotate_overrides, non_constant_identifier_names, override_on_non_overriding_member, avoid_returning_null_for_void, prefer_is_not_empty, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/socal_card.dart';
import 'package:mien_spa_mobile/screens/sign_up/components/sign_up_form.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Text(
                "Đăng ký tài khoản",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              Text(
                "Hoàn thành thông tin chi tiết của bạn hoặc tiếp tục \nvới mạng xã hội",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.07,
              ),
              SignUpForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
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
              Text(
                "By continuing your confirm that you agree \nwith out Term and Condition",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
