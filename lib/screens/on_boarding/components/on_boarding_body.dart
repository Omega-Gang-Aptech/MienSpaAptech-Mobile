// ignore_for_file: unused_import, prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, must_be_immutable, library_private_types_in_public_api, unnecessary_import, unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/home_page/home_page_screen.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/on_boarding/components/on_boarding_content.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:mien_spa_mobile/screens/sign_up/sign_up_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({Key? key}) : super(key: key);

  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng đến với Mien Spa, Hãy mua sắm!",
    },
    {
      "text": "Chúng tôi giúp mọi người kết nối với \ntrên khắp Việt Nam",
    },
    {
      "text":
          "Chúng tôi chỉ cách dễ dàng để mua sắm. \nChỉ cần ở nhà với chúng tôi",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/spa.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    splashColor: Colors.grey.withOpacity(.1),
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            "Đăng Nhập",
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: KWhite,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: KWhite,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => OnBoardingPage(
                  text: splashData[index]["text"].toString(),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                  ),
                  DefaultButton(
                    text: Text(
                      "Đăng ký với email",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                    ),
                    press: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    primary: KWhite,
                    onPrimary: KBlack,
                    width: getProportionateScreenWidth(300),
                    height: getProportionateScreenHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(KWhite),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, MainContainer.routeName);
                    },
                    child: Text(
                      'Tôi muốn khám phá thêm',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: KAnimationDuration,
      // margin: EdgeInsets.only(right: 5),
      height: 2,
      width: currentPage == index ? getProportionateScreenWidth(300) : 0,
      decoration: BoxDecoration(
        color: currentPage == index ? KWhite : KPrimaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
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
