// ignore_for_file: prefer_const_constructors, avoid_print, sort_child_properties_last, prefer_final_fields, use_build_context_synchronously, unnecessary_string_interpolations, library_private_types_in_public_api, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_local_variable, unrelated_type_equality_checks, unused_field, prefer_interpolation_to_compose_strings, prefer_null_aware_operators, avoid_function_literals_in_foreach_calls, prefer_adjacent_string_concatenation, unnecessary_null_comparison, sized_box_for_whitespace, deprecated_member_use

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/order_service.dart';
import 'package:mien_spa_mobile/dto/response/serce_response.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/models/booking.dart';
import 'package:mien_spa_mobile/providers/booking_serce_provider/booking_service_notifer.dart';
import 'package:mien_spa_mobile/providers/serce_provider/filtered_serces_provider.dart';
import 'package:mien_spa_mobile/screens/booking/components/service_item.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/select_serce/select_serce_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class StepperBooking extends ConsumerStatefulWidget {
  const StepperBooking({Key? key}) : super(key: key);

  @override
  _StepperBooking createState() => _StepperBooking();
}

class _StepperBooking extends ConsumerState<StepperBooking> {
  // static var _focusNode = FocusNode();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int currentStep = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  var txtCustomerPhone;

  var sum;
  late bool checkCustomerPhone = false;
  late bool checkDataService = true;
  UserRespone user = new UserRespone();
  //Select part
  List<Serce> serceList = [];
  List<MultiSelectItem> dropDownSerce = [];
  List<Booking> _booking = [];

  final selectedDate = StateProvider((ref) => DateTime.now());
  final selectedTimeSlot = StateProvider((ref) => -1);
  final selectedTime = StateProvider((ref) => '');

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    getData();
    getTotal();
    checkLogin();
  }

  Future<void> getTotal() async {
    sum = await ref.read(bookingNotifierProvider.notifier).getCount();
  }

  void getData() async {
    if (await storage.read(key: "booking") != null) {
      var data = await storage.read(key: "booking");
      List<BookingList> list = bookingListFromJson(data!);
      for (var element in list) {
        Booking dataService = Booking(serviceId: element.serviceId);
        if (!mounted) {
          return;
        }
        setState(() {
          _booking.add(dataService);
        });
      }
      if (_booking.isEmpty) {
        if (!mounted) {
          return;
        }
        setState(() {
          checkDataService = true;
        });
      } else {
        if (!mounted) {
          return;
        }
        setState(() {
          checkDataService = false;
        });
      }
    } else {
      if (_booking.isEmpty) {
        if (!mounted) {
          return;
        }
        setState(() {
          checkDataService = true;
        });
      } else {
        if (!mounted) {
          return;
        }
        setState(() {
          checkDataService = false;
        });
      }
    }
  }

  Future<void> checkLogin() async {
    var data = await storage.read(key: "api_account");
    if (data != null) {
      SignInReponse convertData = signInReponseFromJson(data);
      var respone = await BaseAuthorClient()
          .get('/api/Users/' + convertData.id)
          .catchError((err) {});
      if (respone != null) {
        user = userResponeFromJson(respone);
        if (!mounted) {
          return;
        }
        setState(() {
          txtCustomerPhone = user.usPhoneNo;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: KPrimaryColor,
                background: KRed,
              )),
      child: Form(
        key: _formKey,
        child: Stepper(
          physics: ClampingScrollPhysics(),
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            if (checkDataService == true) {
              currentStep = 0;
              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.error,
                body: Center(
                  child: Text(
                    'Bạn chưa chọn dịch vụ , vui lòng chọn dịch vụ',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                btnCancelOnPress: () {},
              ).show();
            } else if (currentStep == 2 &&
                ref.read(selectedTime.notifier).state.isEmpty) {
              currentStep = 2;
              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.error,
                body: Center(
                  child: Text(
                    'Bạn chưa chọn giờ , vui lòng chọn giờ',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                btnCancelOnPress: () {},
              ).show();
            } else if (formKeys[currentStep].currentState!.validate()) {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  headerAnimationLoop: true,
                  dialogType: DialogType.noHeader,
                  title: 'Xác nhận đặt lịch ',
                  titleTextStyle: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  btnCancelText: "Hủy",
                  buttonsTextStyle: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  btnOkText: "Xác nhận",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    EasyLoading.showToast(
                      'loading...',
                      duration: Duration(seconds: 30),
                      // _progress,
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: true,
                    ).then(
                      (value) async {
                        _timer?.cancel();
                        EasyLoading.dismiss();
                        DateTime createNow =
                            DateTime.now().subtract(Duration(hours: 7));
                        List<String> listSerId = [];
                        _booking.forEach((element) {
                          listSerId.add(element.serviceId);
                        });
                        DateTime orderDate = DateTime(
                          ref.read(selectedDate.notifier).state.year,
                          ref.read(selectedDate.notifier).state.month,
                          ref.read(selectedDate.notifier).state.day,
                        );
                        var plusDateTime;
                        if (ref.read(selectedDate.notifier).state.month < 10 &&
                            ref.read(selectedDate.notifier).state.day < 10) {
                          plusDateTime = ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .year
                                  .toString() +
                              "-0" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .month
                                  .toString() +
                              "-0" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .day
                                  .toString() +
                              " " +
                              ref.read(selectedTime.notifier).state +
                              ":00";
                        } else if (ref.read(selectedDate.notifier).state.day <
                            10) {
                          plusDateTime = ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .year
                                  .toString() +
                              "-" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .month
                                  .toString() +
                              "-0" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .day
                                  .toString() +
                              " " +
                              ref.read(selectedTime.notifier).state +
                              ":00";
                        } else if (ref.read(selectedDate.notifier).state.month <
                            10) {
                          plusDateTime = ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .year
                                  .toString() +
                              "-0" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .month
                                  .toString() +
                              "-" +
                              ref
                                  .read(selectedDate.notifier)
                                  .state
                                  .day
                                  .toString() +
                              " " +
                              ref.read(selectedTime.notifier).state +
                              ":00";
                        }

                        DateTime formatDate = DateTime.parse(plusDateTime);
                        OrderSerceRequest orderSerceRequest = OrderSerceRequest(
                          createdAt: DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss')
                              .format(createNow),
                          listSerId: listSerId,
                          orSerEndTime:
                              DateFormat('yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                  .format(formatDate.add(Duration(hours: 1))),
                          orSerPhoneNo: txtCustomerPhone,
                          orSerStartTime:
                              DateFormat('yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                  .format(formatDate),
                          orSerStatus: "Đang tiến hành",
                          orSerUserId: user == null ? null : user.usId,
                          orSerTotal: int.parse(sum),
                          orSerId: "orSerId",
                          updatedAt: null,
                        );
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.noHeader,
                          showCloseIcon: true,
                          desc: 'Bạn đã xác nhận đơn hàng ?',
                          btnOkOnPress: () async {
                            var reponse = await ApiClient()
                                .post("/api/OrdersSer", orderSerceRequest);
                            if (reponse != null) {
                              await storage.delete(key: "total_booking");
                              await storage.delete(key: "booking");
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                body: Center(
                                  child: Text(
                                    'Bạn đã đặt lịch thành công , nhân viên sẽ liên lạc bạn khi lịch hẹn sắp tới',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                btnOkOnPress: () async {
                                  await storage.write(
                                      key: "main_container_select", value: "0");
                                  Navigator.pushNamed(
                                      context, MainContainer.routeName);
                                },
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.error,
                                title: 'Đã có lỗi xảy ra',
                                desc:
                                    'Đặt lịch thất bại xin vui lòng thử lại !',
                                btnCancelText: "Ok",
                                btnCancelOnPress: () {},
                              ).show();
                            }
                          },
                          btnCancelOnPress: () {},
                          btnCancelText: "Hủy",
                          btnOkText: "Xác nhận",
                        ).show();
                      },
                    );
                  },
                ).show();
              } else {
                setState(
                  () {
                    currentStep += 1;
                  },
                );
              }
            }
          },
          onStepCancel: currentStep == 0
              ? null
              : () => setState(
                    () {
                      currentStep -= 1;
                    },
                  ),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                        ),
                      ),
                      child: Text(
                        "XÁC NHẬN",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                      onPressed: details.onStepContinue,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  if (currentStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ),
                        child: Text(
                          "QUAY LẠI",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        ),
                        onPressed: details.onStepCancel,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //bước 1
  Step selectService(BuildContext context, WidgetRef ref) {
    final allService = ref.watch(filteredSercesAllProvider);

    return Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text(
        "Chọn dịch vụ",
        style: GoogleFonts.roboto(
            color: KPrimaryColor, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: formKeys[0],
        child: Column(
          children: <Widget>[
            checkDataService
                ? Text("Không có dịch vụ nào được chọn")
                : Container(
                    height: checkDataService == true
                        ? 0
                        : getProportionateScreenHeight(250),
                    child: ListView.builder(
                      itemCount: _booking.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10)),
                        child: Dismissible(
                          key: Key(_booking[index].serviceId),
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
                            Booking service = Booking(
                              serviceId: _booking[index].serviceId,
                            );
                            setState(() {
                              ref
                                  .read(bookingNotifierProvider.notifier)
                                  .removeService(service);
                              _booking.removeAt(index);
                            });
                            sum = await storage.read(key: "total_booking");
                            if (_booking.isEmpty) {
                              setState(() {
                                checkDataService = true;
                              });
                            }
                          },
                          child: ServiceItem(
                            service: _booking[index],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            DefaultButton(
              text: Text(
                "Thêm dịch vụ",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              press: () {
                Navigator.pushReplacementNamed(
                    context, SelectSerceScreen.routeName);
              },
              primary: KPrimaryColor,
              onPrimary: KWhite,
            )
          ],
        ),
      ),
    );
  }

  //bước 2
  Step enterPhoneField(String? value) {
    return Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text(
        "Vui lòng nhập số điện thoại",
        style: GoogleFonts.roboto(
          color: KPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      content: Form(
        key: formKeys[1],
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(
                    () {
                      txtCustomerPhone = value;
                      checkCustomerPhone = false;
                    },
                  );
                  return KPhoneNullError;
                } else if (!phoneValidatoRegExp.hasMatch(value)) {
                  setState(
                    () {
                      txtCustomerPhone = value;
                      checkCustomerPhone = false;
                    },
                  );
                  return KInvalidPhoneError;
                } else {
                  setState(() {
                    txtCustomerPhone = value;
                    checkCustomerPhone = true;
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Vui lòng nhập số điện thoại',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                labelStyle:
                    TextStyle(decorationStyle: TextDecorationStyle.solid),
                fillColor: KWhite,
                floatingLabelStyle: TextStyle(
                  color: KBlack,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: KBlack,
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              controller: TextEditingController(text: value),
            )
          ],
        ),
      ),
    );
  }

  //bước 3
  Step displayTimeSlot(BuildContext context, WidgetRef ref) {
    var now = ref.watch(selectedDate);
    var timeWatch = ref.watch(selectedTime);
    DateTime startTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    DateTime endTime = DateTime(now.year, now.month, now.day, 20, 0, 0);
    Duration middleTime = Duration(minutes: 60);

    List<String> timeSlotsString = [];
    List<DateTime> timeSlotsDateTime = [];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(middleTime);
      timeSlotsDateTime.add(timeIncrement);
      timeSlotsString.add(DateFormat.Hm().format(timeIncrement));
      startTime = timeIncrement;
    }

    return Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: Text(
        "Chọn ngày và giờ",
        style: GoogleFonts.roboto(
            color: KPrimaryColor, fontWeight: FontWeight.bold),
      ),
      content: Form(
          key: formKeys[2],
          child: Column(
            children: [
              Container(
                color: KWhite,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(children: [
                              Text(
                                '${DateFormat.MMMM().format(
                                  now,
                                )}',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: KBlack,
                                ),
                              ),
                              Text(
                                '${now.day}',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: KBlack,
                                ),
                              ),
                              Text(
                                '${DateFormat.EEEE().format(
                                  now,
                                )}',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: KBlack,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          now = DateTime.now();
                          ref.read(selectedTime.notifier).state = '';
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: now,
                            maxTime: now.add(
                              Duration(days: 7),
                            ),
                            onConfirm: (date) => ref
                                .read(selectedDate.notifier)
                                .update((state) => state = date),
                            onCancel: () => ref
                                .read(selectedTime.notifier)
                                .state = timeWatch,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.calendar_today,
                              color: KBlack,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: getProportionateScreenHeight(300),
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: timeSlotsString.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () {
                          // click for open the calendar
                          timeSlotsDateTime[index].isBefore(DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  now.hour,
                                  now.minute,
                                  now.second))
                              ? AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.noHeader,
                                  animType: AnimType.scale,
                                  btnOkOnPress: () {},
                                  body: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Thời gian bạn chọn đã qua , xin vui lòng lựa thời gian phù hợp',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ).show()
                              : ref.read(selectedTime.notifier).state =
                                  timeSlotsString.elementAt(index);
                        },
                        child: Card(
                          //set color the card
                          color: ref
                                  .read(selectedTime.notifier)
                                  .state
                                  .contains(timeSlotsString.elementAt(index))
                              ? KPrimaryColor
                              : KWhite,
                          child: GridTile(
                            header: ref
                                    .read(selectedTime.notifier)
                                    .state
                                    .contains(timeSlotsString.elementAt(index))
                                ? Icon(
                                    Icons.check,
                                    color: ref
                                            .read(selectedTime.notifier)
                                            .state
                                            .contains(timeSlotsString
                                                .elementAt(index))
                                        ? KWhite
                                        : KBlack,
                                  )
                                : null,
                            child: Center(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${timeSlotsString.elementAt(index)}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: ref
                                                .read(selectedTime.notifier)
                                                .state
                                                .contains(timeSlotsString
                                                    .elementAt(index))
                                            ? KWhite
                                            : KBlack,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Còn trống",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: ref
                                                .read(selectedTime.notifier)
                                                .state
                                                .contains(timeSlotsString
                                                    .elementAt(index))
                                            ? KWhite
                                            : KBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          )),
    );
  }

  //bước 4
  Step finish() {
    return Step(
      state: currentStep >= 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: Text(
        "Hoàn thành",
        style: GoogleFonts.roboto(
            color: KPrimaryColor, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: formKeys[3],
        child: Container(),
      ),
    );
  }

  List<Step> getSteps() => [
        //nhập dịch vụ
        selectService(context, ref),
        //nhập SDT
        enterPhoneField(txtCustomerPhone),
        //chọn thời gian
        displayTimeSlot(context, ref),
        //hoàn thành
        finish()
      ];
}
