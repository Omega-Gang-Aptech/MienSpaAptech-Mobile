// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/dto/response/order_product_response.dart';
import 'package:mien_spa_mobile/models/total.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_detail_item.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/utilities/total_extension.dart';

class ProductHistoryDetails extends StatefulWidget {
  const ProductHistoryDetails({Key? key}) : super(key: key);
  static String routeName = "/order_pro_detail";
  @override
  _ProductHistoryDetailsState createState() => _ProductHistoryDetailsState();
}

class _ProductHistoryDetailsState extends State<ProductHistoryDetails> {
  String convertTotal(int total) {
    Total convert = Total(total: total);
    return convert.dotPrice();
  }

  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)!.settings.arguments as OrderProductReponse;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: KWhite,
        title: Text(
          "#" + order.orProId,
          style: GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: KBlack,
          ),
        ),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: KBlack,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: KLightBlue,
      body: ListView.builder(
        itemCount: order.listProId.length,
        itemBuilder: (context, index) => Column(
          children: [
            ProductHistoryDetailItem(
              ordProQuantity: order.listProId[index].ordProQuantity,
              productId: order.listProId[index].productId,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: KWhite,
        height: getProportionateScreenHeight(250),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Row(
                children: [
                  Text(
                    "Khách hàng: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order.orProUserName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Row(
                children: [
                  Text(
                    "Số điện thoại: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order.orProPhoneNo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ: ",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order.orProAddress,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tiền Ship: ",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    convertTotal(order.orProShip),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Thành tiền: ",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    convertTotal(order.orProTotal),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
