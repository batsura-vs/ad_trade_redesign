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
        border: Border.all(color: outlineBorderColor),
        boxShadow: [
          BoxShadow(
            color: colorGray3.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7, // changes position of shadow
          ),
        ],
      ),

      child: child,
    );
  }
}
