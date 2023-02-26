// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Spacer(
            flex: 3,
          ),
          Text(
            "$text",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 30,
              color: KWhite,
            ),
          ),
        ],
      ),
    );
  }
}
