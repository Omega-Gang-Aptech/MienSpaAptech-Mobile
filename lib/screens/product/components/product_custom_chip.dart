// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onTap;

  const CustomChip({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: isSelected
                ? KPrimaryColor
                : Colors.grey.shade500.withOpacity(.2),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.playfairDisplay(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isSelected ? KWhite : KBlack,
            ),
          ),
        ),
      ),
    );
  }
}
