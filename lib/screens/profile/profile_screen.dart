// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/profile/components/profile_body.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile_screen';
  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return WillPopScope(
      onWillPop: () async {
        await storage.delete(key: "phone");
        await storage.delete(key: "address");
        await storage.delete(key: "date_of_birth");
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chỉnh sửa thông tin cá nhân",
              style: GoogleFonts.lora(
                textStyle: Theme.of(context).textTheme.headline4,
                color: HexColor("#0000"),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () async {
              await storage.delete(key: "phone");
              await storage.delete(key: "address");
              await storage.delete(key: "date_of_birth");
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, MainContainer.routeName);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: KBlack,
            ),
          ),
          backgroundColor: KWhite,
          elevation: 0,
          titleTextStyle: TextStyle(color: KBlack),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ProfileBody(),
        ),
      ),
    );
  }
}
