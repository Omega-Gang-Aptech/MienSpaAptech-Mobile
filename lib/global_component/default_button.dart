// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    this.width,
    this.height,
    this.shape,
    required this.primary,
    required this.onPrimary,
  }) : super(key: key);
  final Text text;
  final GestureTapCallback press;
  final double? width, height;
  final OutlinedBorder? shape;
  final Color primary;
  final Color onPrimary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primary, // background
          onPrimary: onPrimary, // foreground
          shape: shape,
        ),
        onPressed: press,
        child: text,
      ),
    );
  }
}
