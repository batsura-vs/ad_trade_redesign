import 'package:ad_trade_redesing/style/colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final child;
  MyCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colorGray3,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
