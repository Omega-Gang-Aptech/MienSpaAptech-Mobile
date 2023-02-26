// ignore_for_file: unnecessary_null_comparison, unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/customer_animation.dart';
import 'package:mien_spa_mobile/routes/routes.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/on_boarding/on_boarding_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mien Spa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = '/splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    check();
    nextPage();
  }

  Future<void> nextPage() async {
    var checkSign = await storage.read(key: "api_account");
    Timer(const Duration(seconds: 3), () {
      if (checkSign != null) {
        Navigator.popAndPushNamed(context, MainContainer.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
      }
    });
  }

  Future<void> check() async {
    await storage.write(key: "main_container_select", value: "0");
    if (storage.read(key: "img_storage") == null) {
      storage.write(key: "img_storage", value: "0");
    }
    if (storage.read(key: "camera") == null) {
      storage.write(key: "camera", value: "0");
    }
    if (storage.read(key: "phone") == null) {
      storage.write(key: "phone", value: "0");
    }
    if (storage.read(key: "checkLogin") == null) {
      storage.write(key: "checkLogin", value: "0");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/OG_Spa2.png')),
    );
  }
}
