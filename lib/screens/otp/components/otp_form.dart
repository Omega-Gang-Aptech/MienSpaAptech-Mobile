// ignore_for_file: annotate_overrides, prefer_const_constructors, prefer_is_empty, unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables, unnecessary_new, use_build_context_synchronously, unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/request/validate_otp.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/screens/reset_password/reset_password_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key, required this.checkTime}) : super(key: key);
  final bool checkTime;
  @override
  State<OtpForm> createState() => __OtpFormState();
}

class __OtpFormState extends State<OtpForm> {
  late FocusNode pin1FocusNode;
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;

  var txtPin1;
  var txtPin2;
  var txtPin3;
  var txtPin4;
  var txtPin5;
  bool checkValidate = false;
  bool checkOtp = false;
  bool checkTimeOtp = false;
  String error = "Mã otp không được trống";
  String errorValidateOtp = "Mã otp không đúng";
  String errorTimeOtp = "Mã otp đã hết hạn";
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin1FocusNode = FocusNode();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    super.dispose();
  }

  void nextFiled({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Visibility(
            visible: checkValidate,
            child: FormError(
              errors: error,
            ),
          ),
          Visibility(
            visible: checkOtp,
            child: FormError(
              errors: errorValidateOtp,
            ),
          ),
          Visibility(
            visible: checkTimeOtp,
            child: FormError(
              errors: errorTimeOtp,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  // autofocus: true,
                  focusNode: pin1FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpInputDecoration,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      txtPin1 = value;
                    });
                    nextFiled(value: value, focusNode: pin2FocusNode);
                    if (value.length > 0) {
                      setState(() {
                        checkValidate = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpInputDecoration,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      txtPin2 = value;
                    });
                    nextFiled(value: value, focusNode: pin3FocusNode);
                    if (value.length <= 0) {
                      FocusScope.of(context).requestFocus(pin1FocusNode);
                    }
                    if (value.length > 0) {
                      setState(() {
                        checkValidate = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpInputDecoration,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      txtPin3 = value;
                    });
                    nextFiled(value: value, focusNode: pin4FocusNode);
                    if (value.length <= 0) {
                      FocusScope.of(context).requestFocus(pin2FocusNode);
                    }
                    if (value.length > 0) {
                      setState(() {
                        checkValidate = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpInputDecoration,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      txtPin4 = value;
                    });
                    nextFiled(value: value, focusNode: pin5FocusNode);
                    if (value.length <= 0) {
                      FocusScope.of(context).requestFocus(pin3FocusNode);
                    }
                    if (value.length > 0) {
                      setState(() {
                        checkValidate = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpInputDecoration,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      txtPin5 = value;
                    });
                    pin5FocusNode.unfocus();
                    if (value.length <= 0) {
                      FocusScope.of(context).requestFocus(pin4FocusNode);
                    }
                    if (value.length > 0) {
                      setState(() {
                        checkValidate = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          DefaultButton(
            primary: KPrimaryColor,
            onPrimary: KWhite,
            text: Text(
              "Xác nhận",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () async {
              var email = await storage.read(key: "forgot_password_email");
              FocusManager.instance.primaryFocus?.unfocus();
              if (txtPin1 != null &&
                  txtPin2 != null &&
                  txtPin3 != null &&
                  txtPin4 != null &&
                  txtPin5 != null) {
                if (!widget.checkTime) {
                  String number =
                      txtPin1 + txtPin2 + txtPin3 + txtPin4 + txtPin5;
                  if (email != null) {
                    var validateOtp =
                        ValidateOpt(email: email.toString(), otp: number);
                    var respone = await ApiClient()
                        .post('/otp/validateOtp', validateOtp)
                        .catchError((err) {});
                    if (respone != null) {
                      await storage.write(key: "otp", value: number);
                      Navigator.popAndPushNamed(
                          context, ResetPasswordScreen.routeName);
                    } else {
                      setState(() {
                        checkValidate = false;
                        checkOtp = true;
                        checkTimeOtp = false;
                      });
                    }
                  }
                } else {
                  setState(() {
                    checkValidate = false;
                    checkOtp = false;
                    checkTimeOtp = true;
                  });
                }
              } else {
                setState(() {
                  checkValidate = true;
                  checkOtp = false;
                  checkTimeOtp = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
