import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/skin_page/skin_page_logic.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class SkinPage extends StatefulWidget {
  final id, cost, name, color, d3, des, hash, user;

  SkinPage(this.id, this.cost, this.name, this.color, this.d3, this.des, this.hash, this.user);

  @override
  _SkinPageState createState() => _SkinPageState();
}

class _SkinPageState extends SkinPageLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorGray2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.name.toString(),
                style: TextStyle(
                    color: Color(int.parse('0xff${widget.color}')),
                    fontSize: 25,
                    inherit: false),
              ),
            ),
            Text(
              widget.cost.toString(),
              style: fontLoginText,
            ),
          ],
        ),
      ),
      body: Container(
        color: colorGray1,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                    'https://community.cloudflare.steamstatic.com/economy/image/${widget.id}/500x500'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Html(
                        data: widget.des,
                        style: {
                          "div": Style(
                              color: Colors.white, textAlign: TextAlign.center),
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.d3 != null,
                      child: Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff622eb8),
                            ),
                            child: Center(
                              child: Text(
                                remoteConfig.getString('d3'),
                                style: fontLoginText.copyWith(inherit: false),
                              ),
                            ),
                          ),
                          onTap: () {
                            FlutterWebBrowser.openWebPage(
                              url: "https://3d.cs.money/${widget.d3}",
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff0a8d02),
                          ),
                          child: Center(
                            child: Text(
                              remoteConfig.getString('buy'),
                              style: fontLoginText.copyWith(inherit: false),
                            ),
                          ),
                        ),
                        onTap: buyIt,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
