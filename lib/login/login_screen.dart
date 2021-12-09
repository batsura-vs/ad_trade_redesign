import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/modal.dart';
import 'package:ad_trade_redesing/widgets/signin_button.dart';
import 'package:flutter/material.dart';
import 'login_screen_logic.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginScreenLogic {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/money_background_new.png"), fit: BoxFit.fitHeight),
      ),
      child: Scaffold(
        backgroundColor: colorGray1,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Image.asset("assets/images/tr_logo.png"),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isLoading,
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: LoginButton(
                      onClick: login,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
