import 'package:ad_trade_redesing/data/bottom_navbar_helper.dart';
import 'package:ad_trade_redesing/home/earn/earn_screen.dart';
import 'package:ad_trade_redesing/home/home_screen_logic.dart';
import 'package:ad_trade_redesing/home/settings/settings_screen.dart';
import 'package:ad_trade_redesing/home/shop/shop_screen.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final userInfo;

  HomeScreen(this.userInfo);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenLogic {
  @override
  Widget build(BuildContext context) {
    print(widget.userInfo);
    List<BottomNavBarHelper> bottomNavigationBarItems = [
      BottomNavBarHelper(
        icon: Icons.shopping_cart,
        label: 'cart',
        page: ShopScreen(
          widget.userInfo,
        ),
      ),
      BottomNavBarHelper(
        icon: Icons.attach_money,
        label: 'earn',
        page: SettingsScreen(
          widget.userInfo,
        ),
      ),
      BottomNavBarHelper(
        icon: Icons.settings,
        label: 'settings',
        page: SettingsScreen(
          widget.userInfo,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: colorGray1,
      body: bottomNavigationBarItems[itemNow].page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: itemNow,
        backgroundColor: colorGray2,
        onTap: (i) {
          setState(() {
            itemNow = i;
          });
        },
        items: [
          for (var i in bottomNavigationBarItems)
            BottomNavigationBarItem(icon: Icon(i.icon), label: i.label)
        ],
      ),
    );
  }
}
