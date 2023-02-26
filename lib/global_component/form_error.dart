// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final String errors;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          FaIcon(FontAwesomeIcons.exclamation, color: KRed),
          SizedBox(
            width: getProportionateScreenWidth(20),
          ),
          Text(
            "$errors",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KRed,
            ),
          ),
        ],
      ),
    ]);
  }
}
