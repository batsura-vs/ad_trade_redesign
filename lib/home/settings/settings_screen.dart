import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/home/settings/settings_screen_logic.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
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
                GestureDetector(
                  onTap: logout,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: colorText,
                        ),
                        Text(
                          remoteConfig.getString('logout'),
                          style: fontLoginText.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                )
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
                      style: fontLoginText.copyWith(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: remoteConfig.getString('steam_trade_url'),
                        labelStyle: fontAppName.copyWith(fontSize: 17)
                      ),
                    ),
                    Visibility(
                      visible: !loading,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.clear();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    remoteConfig.getString('clear_button'),
                                    style: fontLoginText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: changeTradeUrl,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Text(
                                    remoteConfig.getString('save_button'),
                                    style: fontLoginText,
                                  ),
                                ),
                              ),
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
