// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, duplicate_ignore, use_build_context_synchronously, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';
import 'package:mien_spa_mobile/providers/product_provider/getall_product_provider.dart';

import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_extension.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/screens/product/product_details_screen.dart';

class HomeProduct extends ConsumerWidget {
  const HomeProduct({Key? key}) : super(key: key);

  // late ScrollController controller;

  // @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = new FlutterSecureStorage();
    final products = ref.watch(getAllProductProvider);

    return products.when(
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 500),
          strokeWidth: 4,
        ),
      ),
      data: (products) => products.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(12),
              child: Column(children: [
                Text(
                  "Các sản phẩm nổi bật".toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(285),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: products.length - 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => Material(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: Colors.grey.withOpacity(.1),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProductDetailsScreen.routeName,
                                        arguments: products[index]);
                                  },
                                  child: SizedBox(
                                      width: getProportionateScreenWidth(150),
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        child: DecoratedBox(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          decoration: BoxDecoration(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 10.0,
                                                    blurStyle: BlurStyle.outer),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height:
                                                  getProportionateScreenHeight(
                                                      80),
                                              child: ImageContainer(
                                                boxfit: BoxFit.fill,
                                                imageUrl: ApiUrl.localhost +
                                                    "/image/product/" +
                                                    products[index]
                                                        .featureImgPath,
                                                width: double.infinity,
                                                borderRadius: 10,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 6),
                                                child: Text(
                                                  products[index].proName,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      color: KBlack,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 6),
                                                child: Text(
                                                  maxLines: 3,
                                                  products[index].proContent,
                                                  style: GoogleFonts.roboto(
                                                      color: KBlack,
                                                      textStyle: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              textAlign: TextAlign.center,
                                              products[index].dotPrice(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(thickness: 2),
                                            Container(
                                              width: double.infinity,
                                              height:
                                                  getProportionateScreenHeight(
                                                      30),
                                              decoration: BoxDecoration(
                                                  color: KWhite,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Mua ngay".toUpperCase(),
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        color: KPrimaryColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .anglesRight,
                                                      color: KPrimaryColor,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      )),
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () async {
                            await storage.write(
                                key: "main_container_select", value: "1");
                            Navigator.pushNamed(
                              context,
                              MainContainer.routeName,
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                )
                              ],
                              color: KWhite,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Icon(
                              Icons.arrow_right_alt,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )
          : Center(
              child: Text(
                "Error to fetch product data",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: KRed,
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
