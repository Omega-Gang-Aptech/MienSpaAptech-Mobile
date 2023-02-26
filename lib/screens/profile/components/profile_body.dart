// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_final_fields, sort_child_properties_last, prefer_collection_literals, prefer_adjacent_string_concatenation, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';

import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/user_request.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';

import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/screens/account/components/account_pic.dart';
import 'package:mien_spa_mobile/screens/get_image/set_image_screen.dart';
import 'package:mien_spa_mobile/screens/profile/profile_screen.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address/search_and_select_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  var checkSign = false;
  late UserRespone user;
  var txtName;
  var txtEmail;
  var txtPhone;
  var txtAddress;
  var txtDob;
  Uint8List? image;
  bool _isLoading = true;
  late bool checkName = false;
  late bool checkPhone = false;
  late bool checkAddress = false;
  Timer? _timer;
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
          var bytesImage = base64Decode(getImage);

          setState(() {
            txtName = user.usUserName;
            txtEmail = user.usEmailNo;
            txtPhone = user.usPhoneNo;
            txtAddress = user.usAddress;
            txtDob = user.usDob;
            image = bytesImage;
          });
        } else {
          setState(() {
            txtName = user.usUserName;
            txtEmail = user.usEmailNo;
            txtPhone = user.usPhoneNo;
            txtAddress = user.usAddress;
            txtDob = user.usDob;
          });
        }

        var dataAddress = await storage.read(key: "address");
        var dataPhone = await storage.read(key: "phone");
        var date_of_birth = await storage.read(key: "date_of_birth");
        if (dataAddress != null) {
          setState(() {
            txtAddress = dataAddress;
            txtPhone = dataPhone;
          });
        }
      } else {
        checkLogin();
      }
      Future.delayed(Duration(milliseconds: 600), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if (_isLoading) ...[
              Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
                heightFactor: 16,
              ),
            ] else ...[
              AccountPic(
                img: image,
                icon: FontAwesomeIcons.camera,
                press: () {
                  Navigator.pushNamed(context, SetImagesScreen.routeName);
                },
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    NameTextField(
                      txtName,
                    ),
                    EmailTextField(
                      txtEmail,
                    ),
                    PhoneTextField(
                      txtPhone,
                    ),
                    AddressTextField(
                      txtAddress,
                    ),
                    OrbTextField(
                      txtDob,
                    ),
                    DefaultButton(
                      primary: KPrimaryColor,
                      onPrimary: KWhite,
                      text: Text(
                        "Cập nhật",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                        ),
                      ),
                      press: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        if (checkName == true &&
                            checkPhone == true &&
                            checkAddress == true) {
                          EasyLoading.showToast(
                            'loading...',
                            duration: Duration(seconds: 30),
                            // _progress,
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: true,
                          ).then((value) async {
                            _timer?.cancel();
                            EasyLoading.dismiss();
                            DateTime now = await DateTime.now();
                            var respone = await BaseAuthorClient()
                                .get('/api/Users/' + user.usId.toString())
                                .catchError((err) {});
                            if (respone != null) {
                              UserRequest request =
                                  userRequestFromJson(respone);
                              request.usUserName = txtName.toString();
                              request.updatedAt =
                                  DateFormat('yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                      .format(now);
                              request.usPhoneNo = txtPhone;
                              request.usAddress = txtAddress;
                              request.usPassword = null;
                              request.usDob = txtDob;
                              var js = userRequestToJson(request);
                              var updateUser = await BaseAuthorClient()
                                  .putForm('/api/Users', js, null);
                              if (updateUser != null) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.success,
                                  showCloseIcon: true,
                                  title: 'Thành Công',
                                  desc:
                                      'Bạn đã cập nhập thông tin thành công !',
                                  btnOkOnPress: () {
                                    Navigator.pushReplacementNamed(
                                        context, ProfileScreen.routeName);
                                  },
                                  btnOkIcon: Icons.check_circle,
                                ).show();
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.info,
                                  showCloseIcon: true,
                                  desc: 'Phiên bản hêt hạn',
                                  btnOkOnPress: () => exit(0),
                                  btnOkIcon: Icons.check_circle,
                                ).show();
                              }
                            }
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Column NameTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                checkName = false;
              });
              return KNameNullError;
            } else if (value.length < 5 || value.length > 21) {
              setState(() {
                checkName = false;
              });
              return KNameLengthError;
            } else if (!nameValidatoRegExp.hasMatch(value)) {
              setState(() {
                checkName = false;
              });
              return KInvalidNameError;
            } else {
              txtName = value;
              setState(() {
                checkName = true;
              });
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text("Họ và tên"),
            prefixIcon: Icon(
              FontAwesomeIcons.userAlt,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column OrbTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          onTap: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(DateTime.now().year - 50, 1, 1),
                maxTime: DateTime(DateTime.now().year, 1, 1),
                theme: DatePickerTheme(
                  headerColor: KPrimaryColor,
                  backgroundColor: KWhite,
                  itemStyle: TextStyle(
                      color: KBlack, fontWeight: FontWeight.bold, fontSize: 18),
                  cancelStyle: GoogleFonts.roboto(
                    color: KWhite,
                    fontSize: 16,
                  ),
                  doneStyle: GoogleFonts.roboto(
                    color: KWhite,
                    fontSize: 16,
                  ),
                ), onConfirm: (date) {
              setState(() {
                txtDob = DateFormat('dd/MM/yyyy').format(date).toString();
              });
            },
                currentTime: txtDob != null
                    ? DateFormat("dd/MM/yyyy").parse(txtDob)
                    : DateTime.now(),
                locale: LocaleType.vi);
          },
          decoration: InputDecoration(
            label: Text("Ngày tháng năm sinh"),
            prefixIcon: Icon(
              FontAwesomeIcons.calendarAlt,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column EmailTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            label: Text("Email"),
            prefixIcon: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column PhoneTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            txtPhone = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                txtPhone = value;
                checkPhone = false;
              });
              return KPhoneNullError;
            } else if (!phoneValidatoRegExp.hasMatch(value)) {
              setState(() {
                txtPhone = value;
                checkPhone = false;
              });
              return KInvalidPhoneError;
            } else {
              setState(() {
                txtPhone = value;
                checkPhone = true;
              });
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text("Phone"),
            prefixIcon: Icon(
              FontAwesomeIcons.phone,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column AddressTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                checkAddress = false;
              });
              return KAddressNullError;
            } else {
              setState(() {
                checkAddress = true;
              });
              return null;
            }
          },
          onTap: () async {
            if (txtPhone != null) {
              await storage.write(key: "phone", value: txtPhone);
              await storage.write(key: "date_of_birth", value: txtDob);
            }
            Navigator.pushNamed(context, SearchAndSelectScreen.routeName);
          },
          decoration: InputDecoration(
            label: Text("Địa chỉ"),
            prefixIcon: Icon(
              FontAwesomeIcons.mapMarkedAlt,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
