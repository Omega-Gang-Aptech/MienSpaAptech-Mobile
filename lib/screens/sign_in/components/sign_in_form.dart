// ignore_for_file: prefer_const_constructors, dead_code, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_new, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/sign_in_request.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/screens/login_success/login_success_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);
  @override
  _SingFormState createState() => _SingFormState();
}

class _SingFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();

  late String error = "Email hoặc mật khẩu sai";
  late bool email = false;
  late bool password = false;
  late String txtEmail;
  late String txtPassword;
  late bool checkPhoneandPass = false;
  final storage = new FlutterSecureStorage();

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Visibility(
            visible: checkPhoneandPass,
            child: FormError(
              errors: error,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(1),
          ),
          buildPhoneInputFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPasswordInputFormField(),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            primary: KPrimaryColor,
            onPrimary: KWhite,
            text: Text(
              "Đăng nhập",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            press: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              if (email == true && password == true) {
                EasyLoading.showToast(
                  'loading...',
                  duration: Duration(seconds: 30),
                  // _progress,
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: true,
                ).then((value) async {
                  var account =
                      SignInRequest(email: txtEmail, password: txtPassword);
                  var respone = await ApiClient()
                      .post('/login/signin', account)
                      .catchError((err) {});
                  if (respone != null) {
                    await storage.write(key: "email", value: txtEmail);
                    await storage.write(key: "password", value: txtPassword);
                    await storage.write(key: "api_account", value: respone);
                    await storage.delete(key: "cart");
                    await storage.delete(key: "total");
                    await storage.write(
                        key: "main_container_select", value: "0");
                    Navigator.popAndPushNamed(
                        context, LoginSuccessScreen.routeName);
                  } else {
                    setState(() {
                      checkPhoneandPass = true;
                    });
                  }
                  _timer?.cancel();
                  EasyLoading.dismiss();
                });
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPhoneInputFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          email = false;
          setState(() {
            checkPhoneandPass = false;
          });
          return KEmailNullError;
        } else if (!emailValidatoRegExp.hasMatch(value)) {
          email = false;
          setState(() {
            checkPhoneandPass = false;
          });
          return KInvalidEmailError;
        } else {
          txtEmail = value;
          email = true;
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.envelope,
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

  TextFormField buildPasswordInputFormField() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          password = false;
          setState(() {
            checkPhoneandPass = false;
          });
          return KPassNullError;
        } else {
          txtPassword = value;
          password = true;
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
}
