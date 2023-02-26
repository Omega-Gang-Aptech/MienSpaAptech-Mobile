// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeExpandableFAB extends StatefulWidget {
  const HomeExpandableFAB({Key? key}) : super(key: key);

  @override
  _HomeExpandableFABState createState() => _HomeExpandableFABState();
}

class _HomeExpandableFABState extends State<HomeExpandableFAB> {
  final Uri _urlHotLine = Uri.parse('tel:+84-869-177-683');
  final Uri _urlFacebook = Uri.parse('https://www.facebook.com/taochuu');
  final Uri _urlWebsite = Uri.parse('http://172.20.10.9:3000');

  Future<void> _launchUrlHotLine() async {
    if (!await launchUrl(_urlHotLine)) {
      throw 'Could not launch $_urlHotLine';
    }
  }

  Future<void> _launchUrlFaceBook() async {
    if (!await launchUrl(_urlFacebook)) {
      throw 'Could not launch $_urlFacebook';
    }
  }

  Future<void> _launchUrlWebsite() async {
    if (!await launchUrl(_urlWebsite)) {
      throw 'Could not launch $_urlWebsite';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: SpeedDial(
        direction: SpeedDialDirection.up,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: KPrimaryColor,
        spacing: 5,
        children: [
          SpeedDialChild(
            onTap: _launchUrlHotLine,
            child: Icon(
              Icons.phone,
              color: KWhite,
            ),
            label: "Hotline",
            labelBackgroundColor: KPrimaryColor,
            backgroundColor: KPrimaryColor,
            labelStyle: TextStyle(color: KWhite),
          ),
          SpeedDialChild(
              onTap: _launchUrlFaceBook,
              child: Icon(
                Icons.facebook,
                color: KWhite,
              ),
              label: "Facebook",
              labelStyle: TextStyle(color: KWhite),
              labelBackgroundColor: KPrimaryColor,
              backgroundColor: KPrimaryColor),
          SpeedDialChild(
              onTap: _launchUrlWebsite,
              child: Icon(
                FontAwesomeIcons.globe,
                color: KWhite,
              ),
              label: "Website",
              labelBackgroundColor: KPrimaryColor,
              labelStyle: TextStyle(color: KWhite, fontFamily: "Roboto"),
              backgroundColor: KPrimaryColor),
        ],
      ),
    );
  }
}
