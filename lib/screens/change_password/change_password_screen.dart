// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mien_spa_mobile/screens/change_password/components/change_password_body.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/change_password";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.angleLeft),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: KPrimaryColor,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ChangePasswordBody(),
        ),
      ),
    );
  }
}
