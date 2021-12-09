import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';

import 'modal.dart';

class LoginButton extends StatelessWidget {
  final onClick;
  late String text;

  LoginButton({this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: colorBlue, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Image.asset('assets/images/google_logo.png'),
            ),
            Expanded(
              flex: 2,
              child: Text(
                null == remoteConfig ? "Loading" : remoteConfig.getString('login_button_text').toString(),
                style: fontLoginText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
