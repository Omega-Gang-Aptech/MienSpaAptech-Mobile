// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:mien_spa_mobile/main.dart';
import 'package:mien_spa_mobile/screens/account/account_screen.dart';
import 'package:mien_spa_mobile/screens/blog/blog_details_screen.dart';
import 'package:mien_spa_mobile/screens/blog/blog_screen.dart';

import 'package:mien_spa_mobile/screens/booking/booking_screen.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/change_password/change_password_screen.dart';
import 'package:mien_spa_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:mien_spa_mobile/screens/get_image/set_image_screen.dart';
import 'package:mien_spa_mobile/screens/history/product_history/components/product_history_details.dart';
import 'package:mien_spa_mobile/screens/history/product_history/product_history_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_cancel_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_details_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_finish_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_onConfirm_screen.dart';
import 'package:mien_spa_mobile/screens/history/serce_history/serce_history_screen.dart';
import 'package:mien_spa_mobile/screens/home_page/components/location_google_map.dart';

import 'package:mien_spa_mobile/screens/home_page/home_page_screen.dart';
import 'package:mien_spa_mobile/screens/login_success/login_success_screen.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/on_boarding/on_boarding_screen.dart';
import 'package:mien_spa_mobile/screens/order/order_screen.dart';
import 'package:mien_spa_mobile/screens/otp/otp_screen.dart';
import 'package:mien_spa_mobile/screens/product/product_details_screen.dart';
import 'package:mien_spa_mobile/screens/product/product_screen.dart';
import 'package:mien_spa_mobile/screens/profile/profile_screen.dart';
import 'package:mien_spa_mobile/screens/reset_password/reset_password_screen.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address/search_and_select_screen.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address_order/search_and_select_address_order_screen.dart';
import 'package:mien_spa_mobile/screens/select_serce/components/select_serce_details.dart';
import 'package:mien_spa_mobile/screens/select_serce/select_serce_screen.dart';
import 'package:mien_spa_mobile/screens/serce/serce_details_screen.dart';
import 'package:mien_spa_mobile/screens/serce/serce_screen.dart';
import 'package:mien_spa_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:mien_spa_mobile/screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  HomePageScreen.routeName: (context) => HomePageScreen(),
  BlogScreen.routeName: (context) => BlogScreen(),
  BlogDetailsScreen.routeName: ((context) => BlogDetailsScreen()),
  MainContainer.routeName: (context) => MainContainer(),
  BookingScreen.routeName: (context) => BookingScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SetImagesScreen.routeName: (context) => SetImagesScreen(),
  LocationGoogleMap.routeName: (context) => LocationGoogleMap(),
  SerceScreen.routeName: (context) => SerceScreen(),
  SerceDetailsScreen.routeName: (context) => SerceDetailsScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  SearchAndSelectScreen.routeName: (context) => SearchAndSelectScreen(),
  CartProductScreen.routeName: (context) => CartProductScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  SearchAndSelectAddressOrderScreen.routeName: (context) =>
      SearchAndSelectAddressOrderScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  SelectSerceScreen.routeName: (context) => SelectSerceScreen(),
  SelectSerceDetails.routeName: (context) => SelectSerceDetails(),
  ProductHistoryScreen.routeName: (context) => ProductHistoryScreen(),
  SerceHistoryScreen.routeName: (context) => SerceHistoryScreen(),
  ProductHistoryDetails.routeName: (context) => ProductHistoryDetails(),
  SerceHistoryOnConfirmScreen.routeName: (context) =>
      SerceHistoryOnConfirmScreen(),
  SerceHistoryFinishScreen.routeName: (context) => SerceHistoryFinishScreen(),
  SerceHistoryCancelScreen.routeName: (context) => SerceHistoryCancelScreen(),
  SerceHistoryDetailsScreen.routeName: (context) => SerceHistoryDetailsScreen(),
};
