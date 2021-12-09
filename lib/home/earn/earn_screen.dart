import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/my_card.dart';
import 'package:flutter/material.dart';

import 'earn_screen_logic.dart';

class EarnScreen extends StatefulWidget {
  @override
  _EarnScreenState createState() => _EarnScreenState();
}

class _EarnScreenState extends EarnScreenLogic {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyCard(
            child: GestureDetector(
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('assets/images/google_logo.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          remoteConfig.getString('google_ads'),
                          style: fontAppName.copyWith(fontSize: 25),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              onTap: showRewardedAd,
            ),
          ),
        ],
      ),
    );
  }
}
