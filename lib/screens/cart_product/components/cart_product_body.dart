// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api, unused_import, avoid_unnecessary_containers, prefer_is_empty, prefer_interpolation_to_compose_strings, unnecessary_new, use_build_context_synchronously, prefer_final_fields, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/cart_product_response.dart';
import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:mien_spa_mobile/models/total.dart';
import 'package:mien_spa_mobile/providers/cart_product/cart_product_notifer.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/order/order_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/product_cart_extension.dart';
import 'package:mien_spa_mobile/utilities/total_extension.dart';

class CartProductBody extends ConsumerStatefulWidget {
  const CartProductBody({Key? key}) : super(key: key);

  @override
  _CartProductBodyState createState() => _CartProductBodyState();
}

final valueStateProvider = StateProvider<String>((ref) => "0 VND");

class _CartProductBodyState extends ConsumerState<CartProductBody> {
  List<CartProduct> _cart = [];
  final storage = new FlutterSecureStorage();
  var sum;
  Color primary = KPrimaryColor;
  bool checkCart = false;
  @override
  void initState() {
    super.initState();
    getData();
    getTotal();
  }

  Future<void> getTotal() async {
    sum = await ref.read(cartNotifierProvider.notifier).getCount();
    if (sum != null) {
      setState(() {
        Total total = Total(total: int.parse(sum));
        ref.read(valueStateProvider.notifier).state = total.dotPrice();
      });
    } else {
      ref.read(valueStateProvider.notifier).state = "0 VND";
    }
  }

  void getData() async {
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        setState(() {
          _cart.add(dataCart);
        });
      }
      if (_cart.length <= 0) {
        setState(() {
          primary = KGray;
        });
      }
    } else {
      if (_cart.length <= 0) {
        setState(() {
          primary = KGray;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: _cart.length > 0
              ? Container(
                  height: getProportionateScreenHeight(540),
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10)),
                      child: Dismissible(
                        key: Key(_cart[index].productId.toString()),
                        background: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: KLightPink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              FaIcon(
                                FontAwesomeIcons.trashAlt,
                                color: KPrimaryColor,
                              )
                            ],
                          ),
                        ),
                        onDismissed: (direction) async {
                          CartProduct cart = CartProduct(
                              productId: _cart[index].productId,
                              ordProQuantity: _cart[index].ordProQuantity);
                          setState(() {
                            ref
                                .read(cartNotifierProvider.notifier)
                                .removeProduct(cart);
                            _cart.removeAt(index);
                          });
                          sum = await storage.read(key: "total");
                          if (sum != null) {
                            setState(() {
                              Total total = Total(total: int.parse(sum));
                              ref.read(valueStateProvider.notifier).state =
                                  total.dotPrice();
                            });
                          }
                          if (_cart.length <= 0) {
                            setState(() {
                              primary = KGray;
                            });
                          }
                        },
                        child: CartProductItem(
                          cart: _cart[index],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  height: getProportionateScreenHeight(500),
                  child: Center(
                    child: Text("Không có sản phẩm nào trong giỏ hàng"),
                  ),
                ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
            vertical: getProportionateScreenHeight(10),
          ),
          height: getProportionateScreenWidth(150),
          decoration: BoxDecoration(
            color: KWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(9),
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: KLightPink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.receipt,
                      color: KPrimaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Add voucher code",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: KBlack,
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: ref.watch(valueStateProvider).toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      primary: primary,
                      onPrimary: KWhite,
                      text: Text(
                        "Đặt Hàng",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                        ),
                      ),
                      press: () async {
                        if (_cart.length > 0) {
                          await storage.delete(key: "order_name");
                          await storage.delete(key: "order_phone");
                          await storage.delete(key: "order_address");
                          Navigator.pushNamed(context, OrderScreen.routeName);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CartProductItem extends ConsumerStatefulWidget {
  const CartProductItem({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final CartProduct cart;

  @override
  _CartProductItemState createState() => _CartProductItemState();
}

class _CartProductItemState extends ConsumerState<CartProductItem> {
  CartProductResponse product = new CartProductResponse();
  final storage = new FlutterSecureStorage();
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: KWhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  )
                                ]),
                            child: Material(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(60),
                                onTap: () async {
                                  if (quantity > 1) {
                                    quantity = quantity - 1;
                                    CartProduct cart = CartProduct(
                                        productId: widget.cart.productId,
                                        ordProQuantity: quantity);
                                    await ref
                                        .read(cartNotifierProvider.notifier)
                                        .updateProduct(cart);
                                    var a = await ref
                                        .read(cartNotifierProvider.notifier)
                                        .getCount();
                                    if (a != null) {
                                      setState(() {
                                        Total total =
                                            Total(total: int.parse(a));
                                        ref
                                            .read(valueStateProvider.notifier)
                                            .state = total.dotPrice();
                                      });
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              quantity.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: KPrimaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: KWhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  )
                                ]),
                            child: Material(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(60),
                                onTap: () async {
                                  if (quantity < 10) {
                                    quantity = quantity + 1;
                                    CartProduct cart = CartProduct(
                                        productId: widget.cart.productId,
                                        ordProQuantity: quantity);
                                    await ref
                                        .read(cartNotifierProvider.notifier)
                                        .updateProduct(cart);

                                    var b = await ref
                                        .read(cartNotifierProvider.notifier)
                                        .getCount();
                                    if (b != null) {
                                      setState(() {
                                        Total total =
                                            Total(total: int.parse(b));
                                        ref
                                            .read(valueStateProvider.notifier)
                                            .state = total.dotPrice();
                                      });
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            product.dotPrice(),
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
