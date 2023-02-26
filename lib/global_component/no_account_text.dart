// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/screens/sign_up/sign_up_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn không có tài khoản?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Đăng Ký",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: KPrimaryColor),
          ),
        )
      ],
    );
  }
}
