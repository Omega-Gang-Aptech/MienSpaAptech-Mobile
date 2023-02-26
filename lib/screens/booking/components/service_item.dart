// ignore_for_file: prefer_const_constructors, unnecessary_new, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/booking_serce_reponse.dart';
import 'package:mien_spa_mobile/models/booking.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/booking_service_extension.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({
    Key? key,
    required this.service,
  }) : super(key: key);
  final Booking service;
  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  BookingSerceReponse serce = new BookingSerceReponse();
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    var respone = await ApiClient()
        .get('/api/Serce/' + widget.service.serviceId)
        .catchError((err) {});
    if (respone != null) {
      if (!mounted) {
        return;
      }
      setState(() {
        serce = bookingSerceReponseFromJson(respone.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(10),
              ),
              decoration: BoxDecoration(
                color: KLightWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: serce.seImage != null
                  ? Image(
                      image: NetworkImage(
                        ApiUrl.localhost + "/image/service/" + serce.seImage!,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        Padding(
          padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                serce.seName != null
                    ? Text(
                        serce.seName!,
                        style: TextStyle(
                          fontSize: 16,
                          color: KBlack,
                          overflow: TextOverflow.clip,
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: Text(
                                "Price:",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: KGray,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                serce.dotPrice(),
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: KGray,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
