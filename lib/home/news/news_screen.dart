import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray1,
      body: SafeArea(
        child: WebView(
          initialUrl: '${remoteConfig.getString("serverUrl")}/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
