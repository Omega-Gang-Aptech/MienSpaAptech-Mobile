// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, use_build_context_synchronously, prefer_final_fields, no_leading_underscores_for_local_identifiers
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/global_component/hero_image.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:mien_spa_mobile/providers/cart_product/cart_product_notifer.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/product/components/expaned_text.dart';
import 'package:mien_spa_mobile/screens/product/components/pop_up_menu.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_extension.dart';
import 'package:mien_spa_mobile/config/api_url.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static String routeName = '/product_details_screen';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  late int quantity = 1;
  Timer? _timer;
  int countCart = 0;
  final storage = FlutterSecureStorage();
  List<CartProduct> _cart = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        _cart.add(dataCart);
      }
      setState(() {
        countCart = _cart.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final storage = FlutterSecureStorage();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
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
                    Navigator.pushReplacementNamed(
                        context, MainContainer.routeName);
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
                      product.proName,
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
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: badges.Badge(
                    badgeContent: Text(countCart.toString()),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: KPrimaryColor,
                      shape: badges.BadgeShape.circle,
                      padding: EdgeInsets.all(5),
                    ),
                    badgeAnimation: badges.BadgeAnimation.scale(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pushNamed(
                            context, CartProductScreen.routeName);
                      },
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        size: 28,
                        color: KBlack,
                      ),
                    ),
                  ),
                ),
                PopUpMenu(),
              ],
            ),
          ),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ProductDetailsCarousel(
                  //   imgList: [
                  //     // ignore: prefer_interpolation_to_compose_strings
                  //     ApiUrl.localhost +
                  //         "/image/product/" +
                  //         product.featureImgPath
                  //   ],
                  // ),

                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(300),
                    child: HeroImage(
                      tag: product.proId,
                      launchPhoto: ApiUrl.localhost +
                          "/image/product/" +
                          product.featureImgPath,
                      child: ImageContainer(
                          borderRadius: 0,
                          width: double.infinity,
                          imageUrl: ApiUrl.localhost +
                              "/image/product/" +
                              product.featureImgPath,
                          boxfit: BoxFit.contain),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      product.proName,
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: KRed,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6, bottom: 6, left: 10),
                        child: Text(
                          "Thương hiệu : ",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: KBlack,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 6,
                          left: 6,
                        ),
                        child: Text(
                          product.proBrand,
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: KBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      product.dotPrice(),
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "5",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemSize: 16,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            updateOnDrag: true,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: KPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              print((5 + rating) / 2);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Thông tin sản phẩm",
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: ExpanedText(
                        text: product.proContent,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 100,
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: KWhite,
                  ),
                  child: Row(
                    children: [
                      Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(60),
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity = quantity - 1;
                              });
                            }
                          },
                          child: Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$quantity",
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(60),
                          onTap: () {
                            if (quantity < 10) {
                              setState(() {
                                quantity = quantity + 1;
                              });
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                product.proTurnOn == false
                    ? Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: KWhite,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Đã hết hàng",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: KBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          CartProduct cart = CartProduct(
                              productId: product.proId,
                              ordProQuantity: quantity);
                          Future<bool> check = ref
                              .read(cartNotifierProvider.notifier)
                              .addProduct(cart);
                          if (await check == true) {
                            List<CartProduct> _count = [];
                            var data = await storage.read(key: "cart");
                            List<CartProductList> list =
                                cartProductListFromJson(data!);
                            for (var element in list) {
                              CartProduct dataCart = CartProduct(
                                  ordProQuantity: element.ordProQuantity,
                                  productId: element.productId);
                              _count.add(dataCart);
                            }
                            setState(() {
                              countCart = _count.length;
                            });
                            _timer?.cancel();
                            await EasyLoading.showSuccess(
                              'Đã thêm vào giỏ hàng',
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
                              desc:
                                  'Bạn chỉ có thể thêm tối đa 10 sản phẩm này vào giỏ hàng !',
                              btnCancelText: "Đòng ý",
                              btnCancelOnPress: () {},
                            ).show();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: KWhite,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_shopping_cart_outlined,
                                size: 18,
                                color: KPrimaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Thêm giỏ hàng",
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: KPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
