// ignore_for_file: prefer_interpolation_to_compose_strings, library_private_types_in_public_api, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/cart_product_response.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_cart_extension.dart';

class ProductHistoryDetailItem extends StatefulWidget {
  const ProductHistoryDetailItem({
    Key? key,
    required this.productId,
    required this.ordProQuantity,
  }) : super(key: key);
  final String productId;
  final int ordProQuantity;
  @override
  _ProductHistoryDetailItemState createState() =>
      _ProductHistoryDetailItemState();
}

class _ProductHistoryDetailItemState extends State<ProductHistoryDetailItem> {
  CartProductResponse product = new CartProductResponse();
  late int quantity = widget.ordProQuantity;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    var respone = await ApiClient()
        .get('/api/Product/' + widget.productId)
        .catchError((err) {});
    if (respone != null) {
      setState(() {
        product = productResponseFromJson(respone.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
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
                child: product.featureImgPath != null
                    ? Image(
                        image: NetworkImage(
                          ApiUrl.localhost +
                              "/image/product/" +
                              product.featureImgPath!,
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
              width: SizeConfig.screenWidth * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.proName != null
                      ? Text(
                          product.proName!,
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlack,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              "Quantity:",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: KGray,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              quantity.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: KGray,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              product.dotPrice(),
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
            ),
          ),
        ],
      ),
    );
  }
}
