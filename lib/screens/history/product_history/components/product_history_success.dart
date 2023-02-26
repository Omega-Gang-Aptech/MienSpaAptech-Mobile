// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/models/total.dart';
import 'package:mien_spa_mobile/providers/order_product_provider/filtered_order_prosuct.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_details.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/total_extension.dart';

class ProductHistorySuccess extends ConsumerStatefulWidget {
  const ProductHistorySuccess({Key? key}) : super(key: key);

  @override
  _ProductHistorySuccessState createState() => _ProductHistorySuccessState();
}

class _ProductHistorySuccessState extends ConsumerState<ProductHistorySuccess> {
  String convertTotal(int total) {
    Total convert = Total(total: total);
    return convert.dotPrice();
  }

  @override
  Widget build(BuildContext context) {
    final OrderProduct = ref.watch(filterOrderProductProvider);
    return OrderProduct.when(
      data: (order) => order.isNotEmpty
          ? ListView.builder(
              itemCount: order.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    order[index].orProStatus.contains("Giao hàng thành công")
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    order[index].orProId,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(convertTotal(
                                          order[index].orProTotal)),
                                      Text(order[index].orProStatus)
                                    ]),
                                trailing: Column(
                                  children: [
                                    DefaultButton(
                                      text: Text("Chi tiết"),
                                      press: () {
                                        Navigator.pushNamed(context,
                                            ProductHistoryDetails.routeName,
                                            arguments: order[index]);
                                      },
                                      primary: KPrimaryColor,
                                      onPrimary: KWhite,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                    ),
                                    // DefaultButton(
                                    //   text: Text("Chi tiết"),
                                    //   press: () {},
                                    //   primary: KPrimaryColor,
                                    //   onPrimary: KWhite,
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(60)),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                );
              },
            )
          : Center(
              heightFactor: 15,
              child: Text("Không có đơn hàng",
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
