import 'package:ad_trade_redesing/data/bottom_navbar_helper.dart';
import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/chat/chat_screen.dart';
import 'package:ad_trade_redesing/home/earn/earn_screen.dart';
import 'package:ad_trade_redesing/home/home_screen_logic.dart';
import 'package:ad_trade_redesing/home/news/news_screen.dart';
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
        label: remoteConfig.getString('shop'),
        page: ShopScreen(
          widget.userInfo,
        ),
      ),
      BottomNavBarHelper(
        icon: Icons.attach_money,
        label: remoteConfig.getString('earn'),
        page: EarnScreen(),
      ),
      BottomNavBarHelper(
        icon: Icons.support_agent,
        label: remoteConfig.getString('support'),
        page: ChatScreen(
          user: widget.userInfo,
        ),
      ),
      BottomNavBarHelper(
        icon: Icons.settings,
        label: remoteConfig.getString('settings'),
        page: SettingsScreen(
          widget.userInfo,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: colorGray1,
      body: bottomNavigationBarItems[itemNow].page,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: colorGray2,
        ),
        child: BottomNavigationBar(
          currentIndex: itemNow,
          backgroundColor: colorGray2,
          selectedItemColor: outlineBorderColor,
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
      ),
    );
  }
}
