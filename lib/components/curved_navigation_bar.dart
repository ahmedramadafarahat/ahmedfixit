import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/main.dart';
import 'package:fixit/views/call_center_screen.dart';
import 'package:flutter/material.dart';

import '../views/home_screen.dart';
import '../views/order_screen.dart';
import '../views/services_screen.dart';
import '../views/setting_screen.dart';

class CurvedNavBar extends StatefulWidget {
  CurvedNavBar({super.key, this.userName});
  String? userName;
  @override
  State<CurvedNavBar> createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {
  int index = 0;

  int _activePage = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabItems = [
      HomeScreen(
        userName: widget.userName ?? sharedPrefrence.getString("userName")!,
      ),
      const ServicesScreen(),
      CallCenterScreen(),
      const OrderScreen(),
      const SettingScreen()
    ];
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: kPrimaryColor,
        buttonBackgroundColor: kPrimaryColor,
        height: 70,
        items: const [
          CurvedNavigationBarItem(
            label: 'home',
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
            child: Icon(
              color: Colors.white,
              Icons.home,
              size: 30,
            ),
          ),
          CurvedNavigationBarItem(
            label: 'services',
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
            child: Image(
              height: 30,
              image: AssetImage(
                'assets/icons/services.png',
              ),
            ),
          ),
          CurvedNavigationBarItem(
            label: 'call center',
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
            child: Image(
              height: 35,
              image: AssetImage('assets/icons/call_center.png'),
            ),
          ),
          CurvedNavigationBarItem(
            label: 'order',
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
            child: Image(
              height: 30,
              image: AssetImage(
                'assets/icons/order.png',
              ),
            ),
          ),
          CurvedNavigationBarItem(
            label: 'setting',
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
            child: Icon(
              size: 30,
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _activePage = index;
            },
          );
        },
        letIndexChange: (index) => true,
      ),
      body: _tabItems[_activePage],
    );
  }
}
