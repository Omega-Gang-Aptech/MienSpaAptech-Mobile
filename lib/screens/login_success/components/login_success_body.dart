// ignore_for_file: unused_import, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class LoginSuccessBody extends StatefulWidget {
  const LoginSuccessBody({Key? key}) : super(key: key);

  @override
  _LoginSuccessBodyState createState() => _LoginSuccessBodyState();
}

class _LoginSuccessBodyState extends State<LoginSuccessBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.5,
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Text(
          "Đăng nhập thành công",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            primary: KPrimaryColor,
            onPrimary: KWhite,
            text: Text(
              "Về trang chủ",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainContainer.routeName,
                  ModalRoute.withName(MainContainer.routeName))
              // Navigator.of(context).popAndPushNamed(MainContainer.routeName),
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}

Route _MainContainerRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MainContainer(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
