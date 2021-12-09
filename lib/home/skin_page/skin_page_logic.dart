import 'dart:convert';

import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/skin_page/skin_page.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SkinPageLogic extends State<SkinPage> {
  void buyIt() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: colorGray1,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Expanded(
              child: Text(
                remoteConfig.getString('cash_out_waiting'),
                style: fontLoginText,
              ),
            ),
          ],
        ),
      ),
    );
    var data = await http.post(
        Uri.parse('${remoteConfig.getString("serverUrl")}/buy_item'),
        body: jsonEncode(
            {'token': widget.user.tokenId, 'item_hash_name': widget.hash}));
    if (data.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Success, check your steam. If you can`t find trade offer please wait 5 minutes or write to the technical support :)',
            style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            data.body,
            style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
