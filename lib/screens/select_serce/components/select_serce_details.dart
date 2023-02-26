// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/serce_response.dart';
import 'package:mien_spa_mobile/global_component/hero_image.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';
import 'package:mien_spa_mobile/models/booking.dart';
import 'package:mien_spa_mobile/providers/booking_serce_provider/booking_service_notifer.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/serce_extension.dart';

class SelectSerceDetails extends ConsumerStatefulWidget {
  const SelectSerceDetails({Key? key}) : super(key: key);
  static String routeName = '/select_serce_details_screen';
  @override
  _SelectSerceDetailsState createState() => _SelectSerceDetailsState();
}

class _SelectSerceDetailsState extends ConsumerState<SelectSerceDetails> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    final serce = ModalRoute.of(context)!.settings.arguments as Serce;
    Timer? _timer;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: serce.seTurnOn == false
          ? FloatingActionButton.extended(
              backgroundColor: KGray,
              label: const Text(
                'Dịch vụ tạm ngưng cung cấp',
                style: TextStyle(
                  fontFamily: "roboto",
                  fontSize: 20,
                ),
              ),
              onPressed: () async {},
            )
          : FloatingActionButton.extended(
              backgroundColor: KPrimaryColor,
              label: const Text(
                'Chọn dịch vụ',
                style: TextStyle(
                  fontFamily: "roboto",
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                Booking booking = Booking(serviceId: serce.seId);
                Future<bool> check = ref
                    .read(bookingNotifierProvider.notifier)
                    .addService(booking);
                if (await check == true) {
                  await EasyLoading.showSuccess(
                    'Dịch vụ đã được chọn',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: true,
                  );
                } else {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.noHeader,
                    title: 'Thông báo',
                    desc: 'Dịch vụ này đã có trong danh sách được chọn!',
                    btnCancelText: "Đồng ý",
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: KWhite,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.arrow_back,
                  color: KBlack,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  serce.seName,
                  maxLines: 1,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w500,
                    color: KBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(300),
                child: HeroImage(
                  tag: serce.seId,
                  launchPhoto:
                      ApiUrl.localhost + "/image/service/" + serce.seImage,
                  child: ImageContainer(
                      borderRadius: 0,
                      width: double.infinity,
                      imageUrl:
                          ApiUrl.localhost + "/image/service/" + serce.seImage,
                      boxfit: BoxFit.contain),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Center(
                  child: Text(
                    serce.seName,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: KRed,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10),
                    child: Text(
                      "Giá : ",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      serce.dotPrice(),
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Thông tin dịch vụ",
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        serce.seNote,
                        style: GoogleFonts.roboto(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "Quy trình",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        serce.seDescription,
                        style: GoogleFonts.roboto(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
