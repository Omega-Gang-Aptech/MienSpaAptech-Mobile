// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unnecessary_new, non_constant_identifier_names, library_private_types_in_public_api

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/change_password.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/screens/on_boarding/on_boarding_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String conform_password;
  late String oldPassword;
  late bool checkpassword = false;
  late bool checkConfirmPasswrod = false;
  late bool checkOldPassword = false;
  final storage = new FlutterSecureStorage();
  late String error = "Mật khẩu cũ không đúng";
  late String error_new = "Mật khẩu mới không được giống với\n mật khẩu cũ";
  late bool checkOldPass = false;
  late bool checkOldAndNewPass = false;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Visibility(
            visible: checkOldPass,
            child: FormError(
              errors: error,
            ),
          ),
          Visibility(
            visible: checkOldAndNewPass,
            child: FormError(
              errors: error_new,
            ),
          ),
          buildOldPasswordFormField(),
          SizedBox(
            height: 15,
          ),
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
              "Đổi mật khẩu",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              if (checkpassword == true &&
                  checkConfirmPasswrod == true &&
                  checkOldPassword == true) {
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
                    var account = await storage.read(key: "api_account");
                    if (account != null) {
                      SignInReponse convertData =
                          signInReponseFromJson(account);
                      var changePassword = ChangePasswordRequest(
                        newPassword: password,
                        oldPassword: oldPassword,
                        userId: convertData.id,
                      );
                      var respone = await BaseAuthorClient()
                          .put('/api/UserChangePassword', changePassword)
                          .catchError((err) {});
                      if (respone != null) {
                        if (respone.toString() == "true") {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            title: 'Thành Công',
                            dismissOnTouchOutside: false,
                            dismissOnBackKeyPress: false,
                            desc:
                                'Đổi mật khẩu thành công. Vui lòng đăng nhập để sử dụng nhiều tính năng hấp dẫn !',
                            btnOkOnPress: () async {
                              await storage.delete(key: "cart");
                              await storage.write(
                                  key: "main_container_select", value: "0");
                              await storage.delete(key: "email");
                              await storage.delete(key: "password");
                              await storage.delete(key: "api_account");
                              await storage.delete(key: "total");
                              Navigator.popAndPushNamed(
                                  context, OnBoardingScreen.routeName);
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        } else {
                          setState(() {
                            checkOldAndNewPass = true;
                          });
                        }
                      } else {
                        setState(() {
                          checkOldPass = true;
                        });
                      }
                    }
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkOldPassword = false;
          });
          return KPassNullError;
        } else {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            oldPassword = value;
            checkOldPassword = true;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu cũ",
        hintText: "Nhập mật khẩu cũ của bạn",
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkpassword = false;
          });
          return KPassNullError;
        } else if (value.length < 8) {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkpassword = false;
          });
          return KShortPassError;
        } else if (!passwrodValidatoRegExp.hasMatch(value)) {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkpassword = false;
          });
          return KInvalidPasswordError;
        } else {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkpassword = true;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Mật Khẩu mới",
        hintText: "Nhập mật khẩu mới của bạn",
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
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkConfirmPasswrod = false;
          });
          return KComfirmPassNull;
        } else if (password != value) {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
            checkConfirmPasswrod = false;
          });
          return KMatchPassError;
        } else {
          setState(() {
            checkOldPass = false;
            checkOldAndNewPass = false;
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
