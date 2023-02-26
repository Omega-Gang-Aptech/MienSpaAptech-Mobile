// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/booking/components/stepper_booking.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class BookingScreen extends StatefulWidget {
  static String routeName = '/booking_screen';
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await storage.write(key: "main_container_select", value: "0");
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: GestureDetector(
        onVerticalDragDown: (details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: KWhite,
              title: Text(
                "Đặt lịch giữ chỗ",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KBlack,
                ),
              ),
              centerTitle: true,
            ),
            body: StepperBooking(),
          ),
        ),
      ),
    );
  }
}
