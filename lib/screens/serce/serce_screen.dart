// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/providers/serce_provider/filtered_serces_provider.dart';
import 'package:mien_spa_mobile/screens/serce/components/custom_serce_card.dart';
import 'package:mien_spa_mobile/screens/serce/serce_details_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';

class SerceScreen extends StatefulWidget {
  const SerceScreen({Key? key}) : super(key: key);
  static String routeName = '/serce_screen';

  @override
  _SerceScreenState createState() => _SerceScreenState();
}

class _SerceScreenState extends State<SerceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: KWhite,
          elevation: 10,
          leading: InkWell(
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
                      Navigator.pushNamed(context, SerceDetailsScreen.routeName,
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
