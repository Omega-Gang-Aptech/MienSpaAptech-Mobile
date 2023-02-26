// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, unnecessary_new, unused_local_variable, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mien_spa_mobile/screens/account/account_screen.dart';
import 'package:mien_spa_mobile/screens/blog/blog_screen.dart';
import 'package:mien_spa_mobile/screens/booking/booking_screen.dart';
import 'package:mien_spa_mobile/screens/home_page/home_page_screen.dart';
import 'package:mien_spa_mobile/screens/product/product_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:mien_spa_mobile/config/size_config.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);
  static String routeName = '/main_container';

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;
  final storage = new FlutterSecureStorage();
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePageScreen(),
    ProductScreen(),
    BookingScreen(),
    BlogScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) async {
    await storage.write(key: "main_container_select", value: index.toString());
    setState(() {
      _select();
    });
  }

  @override
  void initState() {
    super.initState();
    _select();
  }

  void _select() async {
    var main_container_select =
        await storage.read(key: "main_container_select");
    setState(() {
      _selectedIndex = int.parse(main_container_select.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            showUnselectedLabels: true,
            iconSize: 30,
            unselectedLabelStyle: TextStyle(
                overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
            selectedFontSize: 13,
            unselectedFontSize: 12,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: "Home",
                icon: Icon(Icons.home_outlined, size: 17),
                label: 'Home',
                activeIcon: Icon(Icons.home, size: 17),
              ),
              BottomNavigationBarItem(
                tooltip: "Dịch vụ",
                icon: Icon(Icons.shopping_bag_outlined, size: 17),
                label: 'Sản phẩm',
                activeIcon: Icon(Icons.shopping_bag, size: 17),
              ),
              BottomNavigationBarItem(
                tooltip: "Đặt lịch",
                icon: Icon(Icons.calendar_month_outlined, size: 17),
                label: 'Đặt lịch',
                activeIcon: Icon(Icons.calendar_month_outlined, size: 17),
              ),
              BottomNavigationBarItem(
                tooltip: "Khám phá",
                icon: Icon(Icons.auto_awesome_outlined, size: 17),
                label: 'Khám phá',
                activeIcon: Icon(Icons.auto_awesome, size: 17),
              ),
              BottomNavigationBarItem(
                tooltip: "Tài khoản",
                icon: Icon(Icons.account_circle_outlined, size: 17),
                label: 'Tài khoản',
                activeIcon: Icon(
                  Icons.account_circle,
                  size: 17,
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: KPrimaryColor,
            backgroundColor: HexColor("#eff7f2"),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ));
  }
}
