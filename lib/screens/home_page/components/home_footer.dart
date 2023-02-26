// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/custom_tag.dart';

import 'package:mien_spa_mobile/screens/home_page/components/location_google_map.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({Key? key}) : super(key: key);

  @override
  _HomeFooterState createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  blurStyle: BlurStyle.outer),
            ],
          ),
          child: Column(children: [
            Image.asset(
              "assets/images/OG_Spa2_update.png",
              height: getProportionateScreenHeight(200),
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hệ thống làm đẹp hàng đầu Việt Nam",
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Miên Spa luôn nỗ lực không ngừng để đem đến cho khách hàng những dịch vụ hoàn hảo nhất",
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Hotline ",
                          style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTag(
                          backgroundColor: KPrimaryColor,
                          width: double.infinity,
                          children: [
                            Icon(
                              Icons.phone,
                              color: KWhite,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "0938887761",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, color: KWhite),
                            )
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Email",
                          style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTag(
                          backgroundColor: KPrimaryColor,
                          width: double.infinity,
                          children: [
                            Icon(
                              Icons.email,
                              color: KWhite,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "mienspa@gmail.com",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, color: KWhite),
                            )
                          ]),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LocationGoogleMap.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Địa chỉ",
                            style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        CustomTag(
                            backgroundColor: KPrimaryColor,
                            width: double.infinity,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: KWhite,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  "17 Miếu nổi , phường 2 , quận Phú Nhuận",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      color: KWhite),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 6, right: 6, top: 6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Thời gian làm việc",
                          style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTag(
                          backgroundColor: KPrimaryColor,
                          width: double.infinity,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: KWhite,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Flexible(
                              child: Text(
                                "8h30 - 19h30 Thứ 2 - CN (kể cả ngày lễ)",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, color: KWhite),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
