// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously, non_constant_identifier_names
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/forgot_password.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String conform_password;
  late bool checkpassword = false;
  late bool checkConfirmPasswrod = false;
  final storage = new FlutterSecureStorage();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPasswordFormField(),
          SizedBox(
            height: 15,
          ),
          buildCofrimPasswordFormField(),
          SizedBox(
            height: 15,
          ),
          DefaultButton(
            primary: KPrimaryColor,
            onPrimary: KWhite,
            text: Text(
              "Gửi OTP",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              if (checkpassword == true && checkConfirmPasswrod == true) {
                EasyLoading.showToast(
                  'loading...',
                  duration: Duration(seconds: 30),
                  // _progress,
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: true,
                ).then(
                  (value) async {
                    var email =
                        await storage.read(key: "forgot_password_email");
                    var otp = await storage.read(key: "otp");
                    var forgotpassword = ForgotpasswordRequest(
                        email: email.toString(),
                        otp: otp.toString(),
                        password: password);
                    EasyLoading.showToast(
                      'loading...',
                      duration: Duration(seconds: 20),
                      // _progress,
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: true,
                    ).then((value) async {
                      _timer?.cancel();
                      EasyLoading.dismiss();
                      var respone = await ApiClient()
                          .post('/otp/forgot_password', forgotpassword)
                          .catchError((err) {});
                      if (respone != null) {
                        _timer?.cancel();
                        EasyLoading.dismiss();
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: true,
                          title: 'Thành Công',
                          desc:
                              'Đổi mật khẩu thành công. Vui lòng đăng nhập để sử dụng nhiều tính năng hấp dẫn !',
                          btnOkOnPress: () {
                            Navigator.popAndPushNamed(
                                context, SignInScreen.routeName);
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      } else {
                        _timer?.cancel();
                        EasyLoading.dismiss();
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.error,
                          showCloseIcon: true,
                          title: 'Thất bại',
                          desc: 'Bạn đã hết thời gian cho phép',
                          btnOkOnPress: () {
                            Navigator.popAndPushNamed(
                                context, ForgotPasswordScreen.routeName);
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      }
                    });
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkpassword = false;
          });
          return KPassNullError;
        } else if (value.length < 8) {
          setState(() {
            checkpassword = false;
          });
          return KShortPassError;
        } else if (!passwrodValidatoRegExp.hasMatch(value)) {
          setState(() {
            checkpassword = false;
          });
          return KInvalidPasswordError;
        } else {
          setState(() {
            checkpassword = true;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Nhập mật khẩu của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.key,
          color: KBlack,
        ),
        floatingLabelStyle: TextStyle(
          color: KBlack,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KBlack,
          ),
        ),
      ),
    );
  }

  TextFormField buildCofrimPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkConfirmPasswrod = false;
          });
          return KComfirmPassNull;
        } else if (password != value) {
          setState(() {
            checkConfirmPasswrod = false;
          });
          return KMatchPassError;
        } else {
          setState(() {
            checkConfirmPasswrod = true;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.key,
          color: KBlack,
        ),
        floatingLabelStyle: TextStyle(
          color: KBlack,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KBlack,
          ),
        ),
      ),
    );
  }
}
