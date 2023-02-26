// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, non_constant_identifier_names, annotate_overrides, prefer_is_not_empty, avoid_returning_null_for_void, deprecated_member_use, prefer_typing_uninitialized_variables, unused_element

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/sign_up_request.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';

import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String conform_password;
  final error = "Email đã được đăng ký";
  late bool checkname = false;
  late bool checkemail = false;
  late bool checkpassword = false;
  late bool checkConfirmPasswrod = false;
  late bool checkEmailInData = false;
  late String txtUserName;
  late String txtEmail;
  late String txtPassword;
  Timer? _timer;

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Visibility(
            visible: checkEmailInData,
            child: FormError(
              errors: error,
            ),
          ),
          buildUserNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildCofrimPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButton(
            primary: KPrimaryColor,
            onPrimary: KWhite,
            text: Text(
              "Đăng Ký",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              if (checkemail == true &&
                  checkpassword == true &&
                  checkConfirmPasswrod == true &&
                  checkname == true) {
                var sign_up = SignUpRequest(
                  email: txtEmail,
                  password: txtPassword,
                  username: txtUserName,
                );
                var respone = await ApiClient()
                    .post('/login/signup', sign_up)
                    .catchError((err) {});
                EasyLoading.showToast(
                  'loading...',
                  duration: Duration(seconds: 20),
                  // _progress,
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: true,
                ).then((value) async {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  if (respone != null) {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Thành Công',
                      desc:
                          'Đăng Ký Thành Công. Vui lòng đăng nhập để sử dụng nhiều tính năng hấp dẫn !',
                      btnOkOnPress: () {
                        Navigator.popAndPushNamed(
                            context, SignInScreen.routeName);
                      },
                      btnOkIcon: Icons.check_circle,
                    ).show();
                  } else {
                    setState(() {
                      checkEmailInData = true;
                    });
                  }
                });
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkname = false;
            checkEmailInData = false;
          });
          return KNameNullError;
        } else if (value.length < 5 || value.length > 21) {
          setState(() {
            checkname = false;
            checkEmailInData = false;
          });
          return KNameLengthError;
        } else if (!nameValidatoRegExp.hasMatch(value)) {
          setState(() {
            checkname = false;
            checkEmailInData = false;
          });
          return KInvalidNameError;
        } else {
          txtUserName = value;
          setState(() {
            checkname = true;
            checkEmailInData = false;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Nhập tên của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.userAlt,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            checkemail = false;
            checkEmailInData = false;
          });
          return KEmailNullError;
        } else if (!emailValidatoRegExp.hasMatch(value)) {
          setState(() {
            checkemail = false;
            checkEmailInData = false;
          });
          return KInvalidEmailError;
        } else {
          txtEmail = value;
          setState(() {
            checkEmailInData = false;
            checkemail = true;
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.solidEnvelope,
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
      onSaved: (newValue) => password = newValue!,
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
      onSaved: (newValue) => conform_password = newValue!,
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
          txtPassword = password;
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

Route _MainContainerRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MainContainer(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
