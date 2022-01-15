import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/skin_page/skin_page_logic.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class SkinPage extends StatefulWidget {
  final id, cost, name, color, d3, des, hash, user;

  SkinPage(this.id, this.cost, this.name, this.color, this.d3, this.des,
      this.hash, this.user);

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
                  inherit: false,
                ),
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
                flex: 2,
                child: Center(
                  child: SingleChildScrollView(
                    child: Image.network(
                        'https://community.cloudflare.steamstatic.com/economy/image/${widget.id}/500x500'),
                  ),
                ),
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
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: widget.d3 != null,
                        child: Expanded(
                          child: OutlineIconButton(
                            color: outlineBorderColor,
                            onTap: () {
                              FlutterWebBrowser.openWebPage(
                                url: "https://3d.cs.money/${widget.d3}",
                              );
                            },
                            text: remoteConfig.getString('d3'),
                            icon: Icons.center_focus_strong_outlined,
                            styleText: fontLoginText.copyWith(inherit: false),
                          ),
                        ),
                      ),
                      Expanded(
                        child: OutlineIconButton(
                          color: outlineBorderColor,
                          onTap: buyIt,
                          text: remoteConfig.getString('buy'),
                          icon: Icons.shopping_cart,
                          styleText: fontLoginText.copyWith(inherit: false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
