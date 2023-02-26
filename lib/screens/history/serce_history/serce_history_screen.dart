// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_cancel_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_finish_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_onConfirm_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SerceHistoryScreen extends StatefulWidget {
  const SerceHistoryScreen({Key? key}) : super(key: key);
  static String routeName = '/serce_history_screen';

  @override
  _SerceHistoryScreenState createState() => _SerceHistoryScreenState();
}

class _SerceHistoryScreenState extends State<SerceHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: KBlack,
            isScrollable: true,
            tabs: [
              Tab(
                  child: Text(
                "Chờ xác nhận",
                style: GoogleFonts.roboto(
                  color: KBlack,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Tab(
                  child: Text(
                "Đã hoàn thành",
                style: GoogleFonts.roboto(
                  color: KBlack,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Tab(
                  child: Text(
                "Đã hủy",
                style: GoogleFonts.roboto(
                  color: KBlack,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
          elevation: 1,
          backgroundColor: KWhite,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: KBlack,
            ),
          ),
          title: Text(
            "Lịch sử sử dụng dịch vụ",
            style: GoogleFonts.roboto(
              color: KBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(children: [
          SerceHistoryOnConfirmScreen(),
          SerceHistoryFinishScreen(),
          SerceHistoryCancelScreen(),
        ]),
      )),
    );
  }
}
