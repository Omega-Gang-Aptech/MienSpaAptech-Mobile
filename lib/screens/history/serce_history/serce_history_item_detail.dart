// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/dto/response/serce_response_temp.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';
import 'package:mien_spa_mobile/utilities/serce_temp_extension.dart';

class SerceHistoryItemDetail extends StatefulWidget {
  const SerceHistoryItemDetail({
    Key? key,
    required this.serceId,
  }) : super(key: key);
  final String serceId;

  @override
  _SerceHistoryItemDetailState createState() => _SerceHistoryItemDetailState();
}

class _SerceHistoryItemDetailState extends State<SerceHistoryItemDetail> {
  SerceTemp serce = new SerceTemp();
  TextStyle styleRobotoBold =
      GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18);

  @override
  void initState() {
    super.initState();
    getSerce();
  }

  Future<void> getSerce() async {
    var respone = await ApiClient()
        .get('/api/Serce/' + widget.serceId)
        .catchError((err) {});
    if (respone != null) {
      setState(() {
        serce = serceTempFromJson(respone.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: serce.seImage != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageContainer(
                    height: 100,
                    borderRadius: 0,
                    boxfit: BoxFit.cover,
                    imageUrl: ApiUrl.localhost +
                        "/image/service/" +
                        serce.seImage.toString(),
                    width: 100,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        serce.seName.toString(),
                        style: styleRobotoBold,
                      ),
                      Text(
                        serce.dotPrice(),
                        style: styleRobotoBold,
                      ),
                    ],
                  ),
                ],
              )
            : Container());
  }
}
