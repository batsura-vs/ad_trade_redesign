import 'package:ad_trade_redesing/home/shop/shop_screen_logic.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShopScreen extends StatefulWidget {
  final user;

  ShopScreen(this.user);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends ShopScreenLogic {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: loading ? [Center(child: CircularProgressIndicator())] : [for (var i in items) i],
    );
  }
}
