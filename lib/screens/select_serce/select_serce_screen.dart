// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/providers/serce_provider/filtered_serces_provider.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/select_serce/components/select_serce_details.dart';
import 'package:mien_spa_mobile/screens/serce/components/custom_serce_card.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SelectSerceScreen extends StatefulWidget {
  const SelectSerceScreen({Key? key}) : super(key: key);
  static String routeName = '/select_serce_screen';
  @override
  _SelectSerceScreenState createState() => _SelectSerceScreenState();
}

class _SelectSerceScreenState extends State<SelectSerceScreen> {
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await storage.write(key: "main_container_select", value: "2");
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KWhite,
              elevation: 10,
              title: Text(
                "Dịch vụ",
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: KBlack,
                ),
              ),
              centerTitle: true,
            ),
            body: const _SerceGrid(),
            bottomNavigationBar: Container(
              width: getProportionateScreenWidth(250),
              margin: EdgeInsets.only(
                left: getProportionateScreenWidth(60),
                top: 10,
                bottom: 10,
                right: getProportionateScreenWidth(60),
              ),
              child: DefaultButton(
                height: getProportionateScreenHeight(60),
                width: getProportionateScreenWidth(250),
                text: Text(
                  "Thêm dịch vụ đã được chọn",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                ),
                press: () async {
                  await storage.write(key: "main_container_select", value: "2");
                  Navigator.pushReplacementNamed(
                      context, MainContainer.routeName);
                },
                primary: KPrimaryColor,
                onPrimary: KWhite,
              ),
            )),
      ),
    );
  }
}

class _SerceGrid extends ConsumerWidget {
  const _SerceGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serces = ref.watch(filteredSercesAllProvider);
    return serces.when(
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 500),
          strokeWidth: 4,
        ),
      ),
      data: (serces) => serces.isNotEmpty
          ? SizedBox(
              height: SizeConfig.screenHeight * 0.81,
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                shrinkWrap: true,
                itemCount: serces.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SelectSerceDetails.routeName,
                          arguments: serces[index]);
                    },
                    child: CustomSerceCard(
                      serce: serces[index],
                      width: SizeConfig.screenWidth * 0.6,
                      // width: SizeConfig.screenWidth * 0.425,
                    ),
                  );
                })),
              ),
            )
          : Center(
              heightFactor: 15,
              child: Text("Không tìm thấy sản phẩm phù hợp từ khóa",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ),
      error: (error, stackTrace) => Center(
        child: Text(
          "Error to fetch data",
          style: TextStyle(fontSize: 18, color: KRed),
        ),
      ),
    );
  }
}
