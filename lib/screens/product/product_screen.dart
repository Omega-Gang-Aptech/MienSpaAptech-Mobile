// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_new, no_leading_underscores_for_local_identifiers

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/config/size_config.dart';

import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:mien_spa_mobile/providers/category_provider/filtered_categories.dart';
import 'package:mien_spa_mobile/providers/product_provider/filtered_products_provider.dart';
import 'package:mien_spa_mobile/providers/product_provider/search_product_query_provider.dart';
import 'package:mien_spa_mobile/providers/product_provider/selected_category_provider.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/product/components/product_custom_chip.dart';
import 'package:mien_spa_mobile/screens/product/product_details_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/screens/product/components/product_custom_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static String routeName = '/product_screen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isVisible = false;
  int countCart = 0;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<CartProduct> _cart = [];
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
    return WillPopScope(
      onWillPop: () async {
        await storage.write(key: "main_container_select", value: "0");
        Navigator.pushReplacementNamed(context, MainContainer.routeName);
        return true;
      },
      child: GestureDetector(
        onVerticalDragDown: (details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 1,
                titleSpacing: 0,
                backgroundColor: KWhite,
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Sản phẩm",
                          style: GoogleFonts.playfairDisplay(
                              color: KBlack,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(
                          Icons.search_rounded,
                          size: 28,
                          color: KBlack,
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
                  ],
                )),
            // ignore: prefer_const_literals_to_create_immutables
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(children: <Widget>[
                SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 100),
                  child: Visibility(
                    visible: isVisible,
                    child: _SearchBar(),
                  ),
                ),
                SizedBox(height: 10),
                _CategoryFilters(),
                SizedBox(
                  height: 10,
                ),
                _ProductGrid(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        hintText: "Tìm kiếm tên sản phẩm",
      ),
      onChanged: ref.read(searchProductProvider.notifier).onChange,
    );
  }
}

class _CategoryFilters extends ConsumerWidget {
  const _CategoryFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(filterCategoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return categories.when(
      data: (categories) => categories.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: CustomChip(
                      label: "Tất cả",
                      isSelected: selectedCategory == null,
                      onTap: () {
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .setSelectedCategory(null);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CustomChip(
                              label: categories[index].cateName,
                              isSelected: selectedCategory == categories[index],
                              onTap: () {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .setSelectedCategory(categories[index]);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 500),
          strokeWidth: 4,
        ),
      ),
    );
  }
}

class _ProductGrid extends ConsumerWidget {
  const _ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(filteredProductsProvider);

    return products.when(
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 500),
          strokeWidth: 4,
        ),
      ),
      data: (products) => products.isNotEmpty
          ? SizedBox(
              height: SizeConfig.screenHeight * 0.66,
              child: GridView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (((context, index) {
                  return InkWell(
                    onTap: () {
                      ref.refresh(searchProductProvider.notifier).onChange("");
                      Navigator.pushNamed(
                          context, ProductDetailsScreen.routeName,
                          arguments: products[index]);
                    },
                    child: CustomProductCard(
                      product: products[index],
                      width: SizeConfig.screenWidth * 0.6,
                      onTapCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Hello you tapped at cart ${index + 1} "),
                          ),
                        );
                      },
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
