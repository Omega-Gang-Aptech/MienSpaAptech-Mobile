// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class AccountPic extends StatelessWidget {
  const AccountPic({
    Key? key,
    required this.img,
    this.icon,
    this.press,
  }) : super(key: key);
  final GestureTapCallback? press;
  final Uint8List? img;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: img != null
                    ? Image.memory(
                        img!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/avatar-trang-4.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            icon != null
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: press,
                      splashColor: Colors.grey.withOpacity(.1),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: KPrimaryColor,
                        ),
                        child: Icon(
                          icon,
                          color: HexColor("#ffffff"),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 1,
                  ),
          ],
        )
      ],
    );
  }
}
