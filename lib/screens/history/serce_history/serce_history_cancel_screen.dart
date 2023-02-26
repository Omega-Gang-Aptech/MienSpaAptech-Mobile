import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/providers/order_serce_provider/filtered_order_serce_by_user.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_details_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/utilities/order_serce_extenstion.dart';

class SerceHistoryCancelScreen extends ConsumerStatefulWidget {
  const SerceHistoryCancelScreen({Key? key}) : super(key: key);
  static String routeName = '/serce_history_cancel_screen';

  @override
  _SerceHistoryCancelScreenState createState() =>
      _SerceHistoryCancelScreenState();
}

class _SerceHistoryCancelScreenState
    extends ConsumerState<SerceHistoryCancelScreen> {
  @override
  Widget build(BuildContext context) {
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
                return serceByUser[index].orSerStatus.contains("Hủy lịch")
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
                                      "Mã dịch vụ : ",
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
                                    Text("Thời gian bắt đầu : ",
                                        style: styleRobotoBold),
                                    Text(
                                        DateFormat('yyyy-MM-dd – kk:mm').format(
                                            serceByUser[index].orSerStartTime),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Thời gian kết thúc : ",
                                        style: styleRobotoBold),
                                    Text(
                                        DateFormat('yyyy-MM-dd – kk:mm').format(
                                            serceByUser[index].orSerEndTime),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Tổng giá : ", style: styleRobotoBold),
                                    Text(serceByUser[index].dotPrice(),
                                        style: styleRobotoW500),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text("Trạng thái : ",
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
                                        text: const Text("Chi tiết"),
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
                                    // DefaultButton(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(18.0),
                                    //     ),
                                    //     text: const Text("Hủy lịch"),
                                    //     press: () {},
                                    //     primary: KPrimaryColor,
                                    //     onPrimary: KWhite),
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
              child: Text("Hiện tại chưa có lịch sử sử dụng",
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
