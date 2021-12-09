import 'dart:convert';
import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/skin_page/skin_page.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:ad_trade_redesing/home/shop/shop_screen.dart';
import 'package:ad_trade_redesing/login/login_screen.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopScreenLogic extends State<ShopScreen> {
  bool loading = true;
  List items = [];
  dynamic balance;

  @override
  void initState() {
    super.initState();
    loadShop();
  }

  card(id, cost, name, color, d3, des, hash) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SkinPage(id, cost, name, color, d3, des, hash, widget.user)));
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 3.2,
        width: MediaQuery.of(context).size.width / 3.2,
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: colorBlue,
            border: Border.all(color: Colors.black),
            image: DecorationImage(
                image: NetworkImage(
                    'https://community.cloudflare.steamstatic.com/economy/image/$id/330x192'))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(cost.toString(), style: fontLoginText.copyWith(fontSize: 12))
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: fontLoginText.copyWith(
                        fontSize: 12, color: Color(int.parse('0xff$color'))),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  checkToken() async {
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

  loadShop() async {
    var res = await checkToken();
    if (res) {
      var data = await http.post(Uri.parse('${remoteConfig.getString("serverUrl")}/skins'),
          body: jsonEncode({'token': widget.user.tokenId}));
      if (data.statusCode == 200) {
        var js = jsonDecode(data.body);
        List skins = [];
        for (var i in js) {
          if (i['cost'] == null) {
            var cost = await http.get(Uri.parse(
                '${remoteConfig.getString("serverUrl")}/get_cost?name=${i['hash_name']}'));
            if (cost.statusCode == 200) {
              var j = jsonDecode(cost.body);
              if (j['success']) {
                i['cost'] = j['cost'];
              }
            }
          }
          skins.add(card(i['id'], i['cost'], i['name'], i['color'], i['3d'], i['description'], i['hash_name']));
        }
        for (var i in skins) {
          items.add(i);
        }
      }
      var res = await checkToken();
      if (res) {
        var data = await http.post(
            Uri.parse('${remoteConfig.getString("serverUrl")}/get_my_info'),
            body: jsonEncode({'token': widget.user.tokenId}));
        var js = jsonDecode(data.body);
        setState(() {
          balance = js['balance'];
        });
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
