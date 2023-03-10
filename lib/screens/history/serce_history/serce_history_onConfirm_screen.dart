// ignore_for_file: prefer_interpolation_to_compose_strings, dead_code

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/request/order_service.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/providers/order_serce_provider/filtered_order_serce_by_user.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_details_screen.dart';
import 'package:mien_spa_mobile/services/order_serce_service.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/order_serce_extenstion.dart';

class SerceHistoryOnConfirmScreen extends ConsumerStatefulWidget {
  const SerceHistoryOnConfirmScreen({Key? key}) : super(key: key);
  static String routeName = 'serce_history_onConfirm_screen';

  @override
  _SerceHistoryOnConfirmState createState() => _SerceHistoryOnConfirmState();
}

class _SerceHistoryOnConfirmState
    extends ConsumerState<SerceHistoryOnConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    Timer? _timer;
    final serceByUser = ref.watch(filteredOrderSerceResponseProvider);
    TextStyle styleRobotoBold =
        GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16);
    TextStyle styleRobotoW500 =
        GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16);

    return serceByUser.when(
      loading: () => const Center(
        heightFactor: 15,
        child: CustomCircularProgressIndicator(
          duration: Duration(milliseconds: 500),
          strokeWidth: 4,
        ),
      ),
      data: (serceByUser) => serceByUser.isNotEmpty
          ? ListView.builder(
              itemCount: serceByUser.length,
              itemBuilder: (context, index) {
                return serceByUser[index].orSerStatus.contains("??ang ti???n h??nh")
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(
                                      "M?? d???ch v??? : ",
                                      style: styleRobotoBold,
                                    ),
                                    Text(
                                      serceByUser[index].orSerId,
                                      style: styleRobotoW500,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Th???i gian b???t ?????u : ",
                                        style: styleRobotoBold),
                                    Text(
                                        DateFormat('yyyy-MM-dd ??? kk:mm').format(
                                            serceByUser[index].orSerStartTime),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Th???i gian k???t th??c : ",
                                        style: styleRobotoBold),
                                    Text(
                                        DateFormat('yyyy-MM-dd ??? kk:mm').format(
                                            serceByUser[index].orSerEndTime),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("T???ng gi?? : ", style: styleRobotoBold),
                                    Text(serceByUser[index].dotPrice(),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Tr???ng th??i : ",
                                        style: styleRobotoBold),
                                    Text(serceByUser[index].orSerStatus,
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultButton(
                                        text: const Text("Chi ti???t"),
                                        press: () {
                                          Navigator.pushNamed(
                                              context,
                                              SerceHistoryDetailsScreen
                                                  .routeName,
                                              arguments: serceByUser[index]);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        primary: KPrimaryColor,
                                        onPrimary: KWhite),
                                    DefaultButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        text: const Text("H???y l???ch"),
                                        press: () async {
                                          DateTime now = DateTime.now()
                                              .subtract(Duration(hours: 7));
                                          List<String> listSerceId = [];
                                          for (var item
                                              in serceByUser[index].listSerId) {
                                            String serceId = item;
                                            setState(() {
                                              listSerceId.add(serceId);
                                            });
                                          }
                                          OrderSerceRequest orderSerceRequest =
                                              OrderSerceRequest(
                                            createdAt: DateFormat('yyyy-MM-dd' +
                                                    "T" +
                                                    'HH:mm:ss')
                                                .format(serceByUser[index]
                                                    .createdAt),
                                            updatedAt: DateFormat('yyyy-MM-dd' +
                                                    "T" +
                                                    'HH:mm:ss')
                                                .format(now),
                                            orSerEndTime: serceByUser[index]
                                                .orSerEndTime
                                                .toString(),
                                            orSerStartTime: serceByUser[index]
                                                .orSerStartTime
                                                .toString(),
                                            orSerPhoneNo:
                                                serceByUser[index].orSerPhoneNo,
                                            orSerUserId:
                                                serceByUser[index].orSerUserId,
                                            orSerTotal:
                                                serceByUser[index].orSerTotal,
                                            orSerStatus: "H???y l???ch",
                                            listSerId: listSerceId,
                                          );
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.leftSlide,
                                            headerAnimationLoop: false,
                                            dialogType: DialogType.noHeader,
                                            showCloseIcon: true,
                                            desc: 'B???n ch???c ch???n h???y d???ch v??? ?',
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
                                                  var reponse =
                                                      BaseAuthorClient().put(
                                                          "/api/OrdersSer/" +
                                                              serceByUser[index]
                                                                  .orSerId,
                                                          orderSerceRequest);
                                                  if (reponse != null) {
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType:
                                                          AnimType.leftSlide,
                                                      headerAnimationLoop:
                                                          false,
                                                      dialogType:
                                                          DialogType.success,
                                                      dismissOnTouchOutside:
                                                          false,
                                                      dismissOnBackKeyPress:
                                                          false,
                                                      title: 'Th??nh C??ng',
                                                      desc:
                                                          'B???n ???? h???y th??nh c??ng d???ch v???  !',
                                                      btnOkOnPress: () async {
                                                        ref
                                                            .refresh(
                                                                orderSerceServiceProvider)
                                                            .getOrderSerceByUser();
                                                      },
                                                      btnOkIcon:
                                                          Icons.check_circle,
                                                    ).show();
                                                  } else {
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType:
                                                          AnimType.leftSlide,
                                                      headerAnimationLoop:
                                                          false,
                                                      dialogType:
                                                          DialogType.error,
                                                      title: '???? c?? l???i x???y ra',
                                                      desc:
                                                          'H???y th???t b???i xin vui l??ng th??? l???i !',
                                                      btnCancelText: "Ok",
                                                      btnCancelOnPress: () {},
                                                    ).show();
                                                  }
                                                },
                                              );
                                            },
                                            btnCancelOnPress: () {},
                                            btnCancelText: "H???y",
                                            btnOkText: "X??c nh???n",
                                          ).show();
                                        },
                                        primary: KPrimaryColor,
                                        onPrimary: KWhite),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            )
          : Center(
              heightFactor: 15,
              child: Text("Hi???n t???i ch??a c?? l???ch s??? s??? d???ng",
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
