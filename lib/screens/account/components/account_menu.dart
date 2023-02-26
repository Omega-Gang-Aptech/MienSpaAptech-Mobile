// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class MenuAccount extends StatelessWidget {
  const MenuAccount({
    Key? key,
    required this.title,
    this.icon,
    required this.press,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final bool endIcon;
  final Color? textColor;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: icon != null
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: KLightBlue,
              ),
              child: Icon(
                icon,
                color: KBlue,
              ),
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle:
              Theme.of(context).textTheme.bodyText2?.apply(color: textColor),
        ),
      ),
      trailing: endIcon
          ? Container(
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 18,
                color: KGray,
              ),
            )
          : null,
    );
  }
}
