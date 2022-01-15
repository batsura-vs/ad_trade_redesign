import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/settings/settings_screen_logic.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/button.dart';
import 'package:ad_trade_redesing/widgets/my_card.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final user;

  SettingsScreen(this.user);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends SettingsScreenLogic {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: colorGray2,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AdTrade',
                  style: fontAppName.copyWith(fontSize: 30),
                ),
                OutlineIconButton(
                  color: outlineBorderColor,
                  onTap: logout,
                  text: remoteConfig.getString('logout'),
                  icon: Icons.logout,
                  styleText: fontLoginText,
                ),
              ],
            ),
          ),
          Column(
            children: [
              MyCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.user.picture),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Visibility(
                            visible: !loading,
                            child: Text(
                              widget.user.name,
                              style: fontLoginText.copyWith(fontSize: 14),
                            ),
                          ),
                          Visibility(
                            visible: !loading,
                            child: Text(
                              widget.user.gmail,
                              style: fontLoginText.copyWith(fontSize: 14),
                            ),
                          ),
                          Visibility(
                            visible: !loading,
                            child: Text(
                              '${remoteConfig.getString('balance')}: $balance',
                              style: fontLoginText,
                            ),
                          ),
                          Visibility(
                            visible: loading,
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      style: fontLoginText.copyWith(
                          fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: remoteConfig.getString('steam_trade_url'),
                          labelStyle: fontAppName.copyWith(fontSize: 17)),
                    ),
                    Visibility(
                      visible: !loading,
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlineIconButton(
                              color: outlineBorderColor,
                              onTap: () {
                                setState(() {
                                  controller.clear();
                                });
                              },
                              text: remoteConfig.getString('clear_button'),
                              icon: Icons.cleaning_services_rounded,
                              styleText: fontLoginText,
                            ),
                          ),
                          Expanded(
                            child: OutlineIconButton(
                              color: outlineBorderColor,
                              onTap: changeTradeUrl,
                              text: remoteConfig.getString('save_button'),
                              icon: Icons.save,
                              styleText: fontLoginText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: loading,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
