// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/global_component/form_error.dart';
import 'package:mien_spa_mobile/screens/otp/otp_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String error = "Email chưa đăng ký";
  late String email;
  late bool checkemail = false;
  late bool chekEmailData = false;
  final storage = new FlutterSecureStorage();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Visibility(
            visible: chekEmailData,
            child: FormError(
              errors: error,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  checkemail = false;
                });
                return KEmailNullError;
              } else if (!emailValidatoRegExp.hasMatch(value)) {
                setState(() {
                  checkemail = false;
                });
                return KInvalidPasswordError;
              } else {
                setState(() {
                  checkemail = true;
                });
                email = value;
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
          ),
          SizedBox(
            height: 15,
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
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              if (checkemail == true) {
                EasyLoading.showToast(
                  'loading...',
                  duration: Duration(seconds: 30),
                  // _progress,
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: true,
                ).then(
                  (value) async {
                    var respone = await ApiClient()
                        .postString('/otp/generateOTP', email)
                        .catchError((err) {});
                    if (respone != null) {
                      _timer?.cancel();
                      EasyLoading.dismiss();
                      await storage.write(
                          key: "forgot_password_email", value: email);
                      Navigator.pushNamed(context, OtpScreen.routeName);
                    } else {
                      _timer?.cancel();
                      EasyLoading.dismiss();
                      setState(() {
                        chekEmailData = true;
                      });
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
}
