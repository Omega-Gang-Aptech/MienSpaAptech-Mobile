// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api,, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/providers/serce_provider/filtered_serces_provider.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/screens/serce/serce_details_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/screens/home_page/components/home_service_reuse.dart';

class HomeService extends ConsumerWidget {
  const HomeService({Key? key}) : super(key: key);

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
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    "Các loại dịch vụ",
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            blurRadius: 10.0,
                            blurStyle: BlurStyle.outer)
                      ], borderRadius: BorderRadius.circular(5)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: serces.length,
                        itemBuilder: (context, index) => HomeServiceReuse(
                          description: serces[index].seDescription,
                          icon: Icons.keyboard_arrow_right_outlined,
                          image: ApiUrl.localhost +
                              "/image/service/" +
                              serces[index].seImage,
                          onPress: () {
                            Navigator.pushNamed(
                                context, SerceDetailsScreen.routeName,
                                arguments: serces[index]);
                          },
                          name: serces[index].seName,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Text(
                "Error to fetch service data",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: KRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
