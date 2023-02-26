// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_brace_in_string_interps, must_call_super, library_private_types_in_public_api, unnecessary_new, prefer_interpolation_to_compose_strings, unused_local_variable, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/api_client.dart';

import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/screens/otp/components/otp_form.dart';
import 'package:mien_spa_mobile/screens/otp/otp_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class OtpBody extends StatefulWidget {
  const OtpBody({Key? key}) : super(key: key);

  @override
  _OtpBodyState createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  final storage = new FlutterSecureStorage();
  var email;
  bool checkTime = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future<void> getEmail() async {
    var data = await storage.read(key: "forgot_password_email");
    setState(() {
      email = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Text(
                "Xác minh OTP",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Chúng tôi đã gửi mã của bạn tới " + email.toString(),
                textAlign: TextAlign.center,
              ),
              buildTimer(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.15,
              ),
              OtpForm(
                checkTime: checkTime,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  EasyLoading.showToast(
                    'loading...',
                    duration: Duration(seconds: 30),
                    // _progress,
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: true,
                  ).then(
                    (value) async {
                      var txtEmail =
                          await storage.read(key: "forgot_password_email");
                      var respone = await ApiClient()
                          .postString('/otp/generateOTP', txtEmail.toString())
                          .catchError((err) {});
                      if (respone != null) {
                        _timer?.cancel();
                        EasyLoading.dismiss();
                        Navigator.popAndPushNamed(context, OtpScreen.routeName);
                      } else {
                        _timer?.cancel();
                        EasyLoading.dismiss();
                      }
                    },
                  );
                },
                child: Text(
                  "Gửi lại mã OTP",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Mã của bạn sẽ hết hạn sau "),
        TweenAnimationBuilder(
          tween: Tween(begin: 300.0, end: 0),
          duration: Duration(seconds: 300),
          builder: (context, dynamic value, child) => Text(
            "${value.toInt()}s",
            style: TextStyle(color: KPrimaryColor),
          ),
          onEnd: () {
            setState(() {
              checkTime = true;
            });
          },
        ),
      ],
    );
  }
}
