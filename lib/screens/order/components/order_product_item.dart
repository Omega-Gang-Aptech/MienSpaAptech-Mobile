// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/cart_product_response.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_cart_extension.dart';

class OrderProductItem extends ConsumerStatefulWidget {
  const OrderProductItem({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final CartProduct cart;

  @override
  _OrderProductItemState createState() => _OrderProductItemState();
}

class _OrderProductItemState extends ConsumerState<OrderProductItem> {
  CartProductResponse product = new CartProductResponse();
  late int quantity = widget.cart.ordProQuantity;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    var respone = await ApiClient()
        .get('/api/Product/' + widget.cart.productId)
        .catchError((err) {});
    if (respone != null) {
      setState(() {
        product = productResponseFromJson(respone.toString());
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
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
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
                SizedBox(
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
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
