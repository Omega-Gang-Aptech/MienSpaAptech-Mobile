// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:mien_spa_mobile/screens/history/product_history/product_history_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_screen.dart';
import 'package:mien_spa_mobile/screens/serce/serce_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final storage = new FlutterSecureStorage();
  var checkSign = false;
  bool _isLoading = true;
  late UserRespone user;

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
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    child: InkWell(
                      onTap: (() {
                        Navigator.pushNamed(context, SerceScreen.routeName);
                      }),
                      child: SizedBox(
                        width: 60,
                        height: 70,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    FontAwesomeIcons.tag,
                                    size: 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "B???ng gi?? d???ch v???",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 10),
                                        color: KBlack,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    )),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: InkWell(
                      onTap: () async {
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
                                'B???n ph???i ????ng nh???p ????? c?? th??? theo d??i l???ch s??? ?????t h??ng s???n ph???m',
                            desc:
                                'C??n r???t nhi???u nhi???u t??nh n??ng h???p d???n ??ang ch??? b???n tr???i nghi???m!',
                            btnCancelText: "H???y",
                            btnOkText: "????ng Nh???p",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await storage.write(
                                  key: "main_container_select", value: "0");
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                          ).show();
                        }
                      },
                      child: SizedBox(
                        width: 60,
                        height: 70,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: SizedBox(
                                  height: 25,
                                  child: FaIcon(
                                    FontAwesomeIcons.listCheck,
                                    size: 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "L???ch s??? mua h??ng",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 10),
                                        color: KBlack,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    )),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: InkWell(
                      onTap: () async {
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
                                'B???n ph???i ????ng nh???p ????? c?? th??? theo d??i l???ch s??? ?????t h??ng s???n ph???m',
                            desc:
                                'C??n r???t nhi???u nhi???u t??nh n??ng h???p d???n ??ang ch??? b???n tr???i nghi???m!',
                            btnCancelText: "H???y",
                            btnOkText: "????ng Nh???p",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await storage.write(
                                  key: "main_container_select", value: "0");
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                          ).show();
                        }
                      },
                      child: SizedBox(
                        width: 60,
                        height: 70,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: FaIcon(
                                    FontAwesomeIcons.clockRotateLeft,
                                    size: 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "L???ch s??? s??? d???ng",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 10),
                                        color: KBlack,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    )),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.noHeader,
                          body: Center(
                            child: Text(
                              "Ch???c n??ng ??ang ???????c ph??t tri???n",
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          btnOkOnPress: () {},
                          btnOkText: "X??c nh???n",
                        ).show();
                      },
                      child: SizedBox(
                        width: 60,
                        height: 70,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: FaIcon(
                                    FontAwesomeIcons.gift,
                                    size: 25,
                                    color: Colors.redAccent[400],
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Khuy???n m??i ??u ????i",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 10),
                                        color: KBlack,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    )),
                              )
                            ]),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    ));
  }
}
