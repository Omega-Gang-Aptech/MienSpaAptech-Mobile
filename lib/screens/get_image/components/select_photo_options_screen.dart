// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_constructors, unnecessary_new, unused_import, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mien_spa_mobile/dto/request/sign_in_request.dart';
import 'package:mien_spa_mobile/global_component/button_and_icon.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectPhotoOptionsScreen extends StatefulWidget {
  final Function(ImageSource source) onTap;
  const SelectPhotoOptionsScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SelectPhotoOptionsScreen> createState() =>
      _SelectPhotoOptionsScreenState();
}

class _SelectPhotoOptionsScreenState extends State<SelectPhotoOptionsScreen> {
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            ButtonAndIcon(
              onTap: () async {
                var value = await storage.read(key: "img_storage");
                PermissionStatus _permissionStorageStatus =
                    await Permission.storage.request();
                if (_permissionStorageStatus == PermissionStatus.granted) {
                  await storage.write(key: "img_storage", value: "1");
                  widget.onTap(ImageSource.gallery);
                } else {
                  if (_permissionStorageStatus.isDenied) {
                    await storage.write(key: "img_storage", value: "1");
                  }
                  if (value != null) {
                    if (int.parse(value.toString()) == 1 &&
                        _permissionStorageStatus.isPermanentlyDenied == true) {
                      await storage.write(key: "img_storage", value: "2");
                    }
                    if (int.parse(value.toString()) == 2) {
                      AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.noHeader,
                        title: 'Cấp phép',
                        desc:
                            'Không thể truy cập thư viện ảnh, vui lòng cấp quyền',
                        btnOkOnPress: () {
                          openAppSettings();
                        },
                        btnOkIcon: Icons.check_circle,
                      ).show();
                    }
                  }
                }
              },
              icon: Icons.image,
              textLabel: 'Thư viện ảnh',
              priamry: KGrey200,
              iconColor: KBlack,
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: KBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Hoặc',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonAndIcon(
              onTap: () async {
                var value = await storage.read(key: "camera");
                PermissionStatus _permissionCameraStatus =
                    await Permission.camera.request();
                if (_permissionCameraStatus == PermissionStatus.granted) {
                  await storage.write(key: "camera", value: "1");
                  widget.onTap(ImageSource.camera);
                } else {
                  if (_permissionCameraStatus.isDenied) {
                    await storage.write(key: "camera", value: "1");
                  }
                  if (value != null) {
                    if (int.parse(value.toString()) == 1 &&
                        _permissionCameraStatus.isPermanentlyDenied == true) {
                      await storage.write(key: "camera", value: "2");
                    }
                    if (int.parse(value.toString()) == 2) {
                      AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.noHeader,
                        title: 'Cấp phép',
                        desc: 'Không thể truy cập máy ảnh, vui lòng cấp quyền',
                        btnOkOnPress: () {
                          openAppSettings();
                        },
                        btnOkIcon: Icons.check_circle,
                      ).show();
                    }
                  }
                }
              },
              icon: Icons.camera_alt_outlined,
              textLabel: 'Sử dụng máy ảnh',
              priamry: KGrey200,
              iconColor: KBlack,
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: KBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
