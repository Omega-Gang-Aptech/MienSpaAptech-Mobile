// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, unnecessary_import, unused_import, library_private_types_in_public_api, unnecessary_new, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, unused_local_variable, non_constant_identifier_names, unnecessary_string_interpolations, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/account/components/account_menu.dart';
import 'package:mien_spa_mobile/screens/account/components/account_pic.dart';
import 'package:mien_spa_mobile/screens/change_password/change_password_screen.dart';
import 'package:mien_spa_mobile/screens/history/product_history/product_history_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_screen.dart';
import 'package:mien_spa_mobile/screens/on_boarding/on_boarding_screen.dart';
import 'package:mien_spa_mobile/screens/profile/profile_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key? key}) : super(key: key);

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  final storage = new FlutterSecureStorage();
  var checkSign = false;
  late UserRespone user;
  bool _isLoading = true;
  Uint8List? image;
  @override
  void initState() {
    super.initState();
    checkLogin();
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
        if (user.usImage != null) {
          var getImage = await BaseAuthorClient()
              .get('/image/user/' + user.usImage)
              .catchError((err) {});
          if (getImage != null) {
            var bytesImage = base64Decode(getImage);
            if (!mounted) {
              return;
            }
            setState(() {
              checkSign = true;
              image = bytesImage;
            });
          } else {
            if (!mounted) {
              return;
            }
            setState(() {
              checkSign = true;
            });
          }
        } else {
          if (!mounted) {
            return;
          }
          setState(() {
            checkSign = true;
          });
        }
      } else {
        checkLogin();
      }
    }
    Future.delayed(Duration(milliseconds: 600), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) ...[
              Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
                heightFactor: 16,
              ),
            ] else ...[
              checkSign == true
                  ? Column(
                      children: [
                        AccountPic(
                          img: image,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${user.usUserName}",
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: KBlack,
                          ),
                        ),
                        Divider(
                          height: 30,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        DefaultButton(
                          text: Text(
                            "Đăng nhập / Đăng ký",
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.w500),
                          ),
                          press: () async {
                            await storage.write(
                                key: "main_container_select", value: "0");
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                          primary: KPrimaryColor,
                          onPrimary: KWhite,
                          width: getProportionateScreenWidth(300),
                          height: getProportionateScreenHeight(45),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(100)),
                          // ),
                        ),
                        Divider(
                          color: KGray,
                          height: 30,
                        ),
                      ],
                    ),

              SizedBox(
                height: 20,
              ),
              //Menu
              MenuAccount(
                title: "Thông tin tài khoản",
                icon: Icons.account_circle,
                press: () async {
                  await storage.delete(key: "phone");
                  await storage.delete(key: "address");
                  await storage.delete(key: "date_of_birth");
                  if (checkSign == true) {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  } else {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      dialogType: DialogType.noHeader,
                      title: 'Đăng nhập ngay nhé bạn',
                      desc: 'Nhiều tính năng hấp dẫn đang chờ bạn trải nghiệm!',
                      btnCancelText: "Hủy",
                      btnOkText: "Đăng Nhập",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await storage.write(
                            key: "main_container_select", value: "0");
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ).show();
                  }
                },
              ),
              MenuAccount(
                title: "Đổi mật khẩu",
                icon: Icons.key,
                press: () {
                  if (checkSign == true) {
                    Navigator.pushNamed(
                        context, ChangePasswordScreen.routeName);
                  } else {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      dialogType: DialogType.noHeader,
                      title: 'Đăng nhập ngay nhé bạn',
                      desc: 'Nhiều tính năng hấp dẫn đang chờ bạn trải nghiệm!',
                      btnCancelText: "Hủy",
                      btnOkText: "Đăng Nhập",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await storage.write(
                            key: "main_container_select", value: "0");
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ).show();
                  }
                },
              ),
              MenuAccount(
                title: "Đơn hàng sản phẩm",
                icon: Icons.wallet,
                press: () async {
                  await storage.delete(key: "phone");
                  await storage.delete(key: "address");
                  await storage.delete(key: "date_of_birth");
                  if (checkSign == true) {
                    Navigator.pushNamed(
                        context, ProductHistoryScreen.routeName);
                  } else {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      dialogType: DialogType.noHeader,
                      title:
                          'Bạn phải đăng nhập để có thể theo dõi lịch sử đặt hàng sản phẩm',
                      desc:
                          'Còn rất nhiều nhiều tính năng hấp dẫn đang chờ bạn trải nghiệm!',
                      btnCancelText: "Hủy",
                      btnOkText: "Đăng Nhập",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await storage.write(
                            key: "main_container_select", value: "0");
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ).show();
                  }
                },
              ),
              MenuAccount(
                  title: "Đơn hàng dịch vụ",
                  icon: Icons.airline_seat_flat,
                  press: () async {
                    await storage.delete(key: "phone");
                    await storage.delete(key: "address");
                    await storage.delete(key: "date_of_birth");
                    if (checkSign == true) {
                      Navigator.pushNamed(
                          context, SerceHistoryScreen.routeName);
                    } else {
                      AwesomeDialog(
                        context: context,
                        headerAnimationLoop: true,
                        dialogType: DialogType.noHeader,
                        title:
                            'Bạn phải đăng nhập để có thể theo dõi lịch sử đặt hàng sản phẩm',
                        desc:
                            'Còn rất nhiều nhiều tính năng hấp dẫn đang chờ bạn trải nghiệm!',
                        btnCancelText: "Hủy",
                        btnOkText: "Đăng Nhập",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await storage.write(
                              key: "main_container_select", value: "0");
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                      ).show();
                    }
                  }),
              // MenuAccount(
              //   title: "Information",
              //   icon: Icons.info,
              //   press: () {},
              // ),
              checkSign == true
                  ? MenuAccount(
                      title: "Đăng xuất",
                      icon: Icons.logout,
                      endIcon: false,
                      textColor: KRed,
                      press: () async {
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
                    )
                  : SizedBox(
                      height: 1,
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
