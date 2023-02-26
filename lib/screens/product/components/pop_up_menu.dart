// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: 40,
        width: 40,
        child: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              Navigator.of(context).pushNamed(MainContainer.routeName);
            } else if (result == 1) {
              null;
            }
          },
          position: PopupMenuPosition.under,
          icon: FaIcon(FontAwesomeIcons.ellipsisVertical, color: KBlack),
          itemBuilder: (context) => [
            // ignore: prefer_const_literals_to_create_immutables
            PopupMenuItem(
              value: 0,
              padding: const EdgeInsets.all(10),
              height: 25,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: KBlack,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Trang chủ",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              padding: const EdgeInsets.all(10),
              height: 25,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Center(
                    child: Icon(
                      Icons.assignment_outlined,
                      color: KBlack,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Đơn hàng",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
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
}
