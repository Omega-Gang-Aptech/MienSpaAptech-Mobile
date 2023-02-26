// ignore_for_file: avoid_web_libraries_in_flutter, unnecessary_import, library_private_types_in_public_api, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print, use_build_context_synchronously, unnecessary_new, prefer_interpolation_to_compose_strings, unused_catch_clause

import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/dto/request/user_request.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/screens/get_image/components/common_buttons.dart';
import 'package:mien_spa_mobile/screens/get_image/components/select_photo_options_screen.dart';
import 'package:mien_spa_mobile/screens/profile/profile_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class SetImageBody extends StatefulWidget {
  const SetImageBody({Key? key}) : super(key: key);

  @override
  _SetImageBodyState createState() => _SetImageBodyState();
}

class _SetImageBodyState extends State<SetImageBody> {
  File? _image;
  Timer? _timer;
  late double _progress;
  final storage = new FlutterSecureStorage();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: _pickImage,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Đặt một bức ảnh của chính bạn',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Ảnh làm cho hồ sơ của bạn hấp dẫn hơn',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _showSelectPhotoOptions(context);
                  },
                  child: Center(
                    child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: _image == null
                              ? Text(
                                  'Không có hình ảnh nào được chọn',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: KBlack,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(_image!),
                                  radius: 200.0,
                                ),
                        )),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(KBlack),
                      overlayColor:
                          MaterialStateProperty.all<Color>(KPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_image != null) {
                        _progress = 0;
                        _timer =
                            Timer.periodic(const Duration(milliseconds: 120),
                                (Timer timer) async {
                          EasyLoading.showProgress(_progress,
                              maskType: EasyLoadingMaskType.black,
                              status:
                                  '${(_progress * 100).toStringAsFixed(0)}%');
                          _progress += 0.03;

                          if (_progress >= 1) {
                            _timer?.cancel();
                            EasyLoading.dismiss();
                            var data = await storage.read(key: "api_account");
                            if (data != null) {
                              SignInReponse convertData =
                                  signInReponseFromJson(data.toString());
                              var respone = await BaseAuthorClient()
                                  .get(
                                      '/api/Users/' + convertData.id.toString())
                                  .catchError((err) {});
                              if (respone != null) {
                                UserRequest request =
                                    userRequestFromJson(respone);
                                request.usPassword = null;
                                var js = userRequestToJson(request);
                                var updateimage = await BaseAuthorClient()
                                    .putForm('/api/Users', js, _image!);
                                if (updateimage != null) {
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
                                      Navigator.of(context).pop();
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
                                    dialogType: DialogType.noHeader,
                                    showCloseIcon: true,
                                    desc: 'Phiên bản hêt hạn',
                                    btnOkOnPress: () => exit(0),
                                    btnOkIcon: Icons.check_circle,
                                  ).show();
                                }
                              }
                            }
                          }
                        });
                      }
                    },
                    child: Text(
                      'Cập nhật',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                CommonButtons(
                  onTap: () => _showSelectPhotoOptions(context),
                  backgroundColor: KBlack,
                  textColor: KWhite,
                  textLabel: 'Thêm ảnh',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
