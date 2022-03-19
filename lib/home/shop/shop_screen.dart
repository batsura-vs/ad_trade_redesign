import 'package:ad_trade_redesing/data/config.dart';
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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: labelColor,
                          size: 50,
                        ),
                        Text(
                          remoteConfig.getString('shop'),
                          style: TextStyle(
                            fontSize: 30,
                            color: labelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !loading,
                    child: MyCard(
                      child: Row(
                        children: [
                          Text(
                            balance.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: labelColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.account_balance_wallet,
                            size: 30  ,
                            color: labelColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: loading
                    ? [Center(child: CircularProgressIndicator())]
                    : [for (var i in items) i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
