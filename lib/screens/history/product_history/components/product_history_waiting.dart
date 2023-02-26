// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, annotate_overrides, non_constant_identifier_names, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unnecessary_new, prefer_adjacent_string_concatenation

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/request/order_product_request.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/models/total.dart';
import 'package:mien_spa_mobile/providers/order_product_provider/filtered_order_prosuct.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_details.dart';
import 'package:mien_spa_mobile/screens/history/product_history/product_history_screen.dart';
import 'package:mien_spa_mobile/services/order_product_service.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/utilities/total_extension.dart';

class ProductHistoryWaiting extends ConsumerStatefulWidget {
  const ProductHistoryWaiting({Key? key}) : super(key: key);

  @override
  _ProductHistoryWaitingState createState() => _ProductHistoryWaitingState();
}

class _ProductHistoryWaitingState extends ConsumerState<ProductHistoryWaiting> {
  Timer? _timer;
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
                    order[index].orProStatus.contains("Chờ xác nhận")
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  ListTile(
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
                                    trailing: DefaultButton(
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 5, right: 20, bottom: 0),
                                    child: DefaultButton(
                                      width: getProportionateScreenWidth(300),
                                      text: Text(
                                        "Hủy",
                                        style: GoogleFonts.roboto(
                                          color: KRed,
                                        ),
                                      ),
                                      press: () async {
                                        DateTime now = DateTime.now()
                                            .subtract(Duration(hours: 7));
                                        List<ListProId> listProId = [];
                                        for (var item
                                            in order[index].listProId) {
                                          ListProId pro = new ListProId(
                                              ordProQuantity:
                                                  item.ordProQuantity,
                                              productId: item.productId);
                                          setState(() {
                                            listProId.add(pro);
                                          });
                                        }
                                        OrderProductRequest orderRequest =
                                            OrderProductRequest(
                                          createdAt: order[index].createdAt,
                                          updatedAt: DateFormat('yyyy-MM-dd' +
                                                  "T" +
                                                  'HH:mm:ss')
                                              .format(now),
                                          orProDob: order[index].orProDob,
                                          orProPayStatus:
                                              order[index].orProPayStatus,
                                          orProPayment:
                                              order[index].orProPayment,
                                          orProPhoneNo:
                                              order[index].orProPhoneNo,
                                          orProShip: order[index].orProShip,
                                          orProStatus: "Giao hàng thất bại",
                                          orProAddress:
                                              order[index].orProAddress,
                                          orProTotal: order[index].orProTotal,
                                          orProUserName:
                                              order[index].orProUserName,
                                          orProNote: order[index].orProNote,
                                          orProUserId: order[index].orProUserId,
                                          listProId: listProId,
                                        );
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.leftSlide,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.noHeader,
                                          showCloseIcon: true,
                                          desc: 'Bạn chắc chắn hủy đơn hàng ?',
                                          btnOkOnPress: () async {
                                            EasyLoading.showToast(
                                              'loading...',
                                              duration: Duration(seconds: 30),
                                              // _progress,
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                              dismissOnTap: true,
                                            ).then(
                                              (value) async {
                                                _timer?.cancel();
                                                EasyLoading.dismiss();
                                                var reponse = BaseAuthorClient()
                                                    .put(
                                                        "/api/OrdersPro/" +
                                                            order[index]
                                                                .orProId,
                                                        orderRequest);
                                                if (reponse != null) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.success,
                                                    dismissOnTouchOutside:
                                                        false,
                                                    dismissOnBackKeyPress:
                                                        false,
                                                    title: 'Thành Công',
                                                    desc:
                                                        'Bạn đã hủy thành công !',
                                                    btnOkOnPress: () async {
                                                      ref
                                                          .refresh(
                                                              orderProductServiceProvider)
                                                          .getOrderByUser();
                                                    },
                                                    btnOkIcon:
                                                        Icons.check_circle,
                                                  ).show();
                                                } else {
                                                  AwesomeDialog(
                                                    context: context,
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.error,
                                                    title: 'Đã có lỗi xảy ra',
                                                    desc:
                                                        'Đặt hàng thất bại xin vui lòng thử lại !',
                                                    btnCancelText: "Ok",
                                                    btnCancelOnPress: () {},
                                                  ).show();
                                                }
                                              },
                                            );
                                          },
                                          btnCancelOnPress: () {},
                                          btnCancelText: "Hủy",
                                          btnOkText: "Xác nhận",
                                        ).show();
                                      },
                                      primary: KWhite,
                                      onPrimary: KRed,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(color: KRed)),
                                    ),
                                  ),
                                ],
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
