// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_delivery.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_failed.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_success.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_waiting.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ProductHistoryScreen extends StatefulWidget {
  const ProductHistoryScreen({Key? key}) : super(key: key);
  static String routeName = '/product_history_screen';

  @override
  _ProductHistoryScreenState createState() => _ProductHistoryScreenState();
}

class _ProductHistoryScreenState extends State<ProductHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_literals_to_create_immutables
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
                "Đang giao hàng",
                style: GoogleFonts.roboto(
                  color: KBlack,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Tab(
                  child: Text(
                "Đã giao hàng",
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
          backgroundColor: KWhite,
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Lịch sử mua hàng",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: KBlack,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: KBlack,
            ),
          ),
        ),
        body: const TabBarView(children: [
          ProductHistoryWaiting(),
          ProductHistoryDelivery(),
          ProductHistorySuccess(),
          ProductHistoryFailed(),
        ]),
      )),
    );
  }
}
