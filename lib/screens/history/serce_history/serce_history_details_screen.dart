// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/dto/response/order_serce_response.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_item_detail.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/order_serce_extenstion.dart';

class SerceHistoryDetailsScreen extends StatefulWidget {
  const SerceHistoryDetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/serce_history_detail_screen";

  @override
  _SerceHistoryDetailsScreenState createState() =>
      _SerceHistoryDetailsScreenState();
}

class _SerceHistoryDetailsScreenState extends State<SerceHistoryDetailsScreen> {
  TextStyle styleRobotoBold =
      GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16);
  TextStyle styleRobotoW500 =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    final serceByUserDetail =
        ModalRoute.of(context)!.settings.arguments as OrderSerceResponse;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          "Chi tiết dịch vụ",
          style: GoogleFonts.roboto(
            color: KBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_right),
                  Text(
                    "Mã dịch vụ : ",
                    style: styleRobotoBold,
                  ),
                  Text(
                    serceByUserDetail.orSerId,
                    style: styleRobotoW500,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_right),
                  Text("Thời gian bắt đầu : ", style: styleRobotoBold),
                  Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(serceByUserDetail.orSerStartTime),
                      style: styleRobotoW500),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_right),
                  Text("Thời gian kết thúc : ", style: styleRobotoBold),
                  Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(serceByUserDetail.orSerEndTime),
                      style: styleRobotoW500),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_right),
                  Text("Tổng giá : ", style: styleRobotoBold),
                  Text(serceByUserDetail.dotPrice(), style: styleRobotoW500),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_right),
                  Text("Trạng thái : ", style: styleRobotoBold),
                  Text(serceByUserDetail.orSerStatus, style: styleRobotoW500),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_right),
                      Text("Dịch vụ : ", style: styleRobotoBold),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: serceByUserDetail.listSerId.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SerceHistoryItemDetail(
                                  serceId: serceByUserDetail.listSerId[index],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
