// ignore_for_file: unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/get_image/components/set_image_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SetImagesScreen extends StatelessWidget {
  const SetImagesScreen({Key? key}) : super(key: key);
  static String routeName = '/set_images';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: KPrimaryColor,
      ),
      body: SetImageBody(),
    );
  }
}
