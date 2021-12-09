import 'dart:convert';

import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/settings/settings_screen.dart';
import 'package:ad_trade_redesing/login/login_screen.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SettingsScreenLogic extends State<SettingsScreen> {
  late GoogleSignIn _googleSignIn = GoogleSignIn();
  bool loading = true;
  var balance, tradeUrl;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    init();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  init() async {
    await Firebase.initializeApp();
    getUserInfo();
    controller = TextEditingController();
  }

  checkToken() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    var data = await http.post(
        Uri.parse('${remoteConfig.getString("serverUrl")}/check_token'),
        body: jsonEncode({'token': widget.user.tokenId}));
    if (data.statusCode != 200) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    title: 'AdTrade',
                  )),
          (Route<dynamic> route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid token :(',
            style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  getUserInfo() async {
    var res = await checkToken();
    if (res) {
      var data = await http.post(
          Uri.parse('${remoteConfig.getString("serverUrl")}/get_my_info'),
          body: jsonEncode({'token': widget.user.tokenId}));
      var js = jsonDecode(data.body);
      setState(() {
        balance = js['balance'];
        tradeUrl = js['trade_url'];
        controller.text = tradeUrl.toString();
        loading = false;
      });
    }
  }

  changeTradeUrl() async {
    var res = await checkToken();
    if (res) {
      setState(() {
        loading = true;
      });
      var data = await http.post(
          Uri.parse('${remoteConfig.getString("serverUrl")}/change_trade_url'),
          body: jsonEncode(
              {'token': widget.user.tokenId, 'trade_url': controller.text}));
      if (data.statusCode == 200 && jsonDecode(data.body)['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Trade Url changed :)',
              style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error :(',
              style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() {
        loading = false;
      });
    }
  }

  logout() async {
    await _googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen(title: 'AdTrade')),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
