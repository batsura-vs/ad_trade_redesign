import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/data/user_info.dart';
import 'package:ad_trade_redesing/home/home_screen.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/modal.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../globals.dart';
import 'login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class LoginScreenLogic extends State<LoginScreen> {
  late GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    print('init');
    init();
  }

  init() async {
    await Firebase.initializeApp();
    remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(remoteConfigSettings);
    await remoteConfig.fetchAndActivate();
    setState(() {});
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    login();
  }

  login() async {
    if (remoteConfig != null) {
      setState(() {
        isLoading = true;
      });
      var googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount!.authentication;
      print('${remoteConfig.getString("serverUrl")}/login/${googleSignInAuth.idToken}');
      var data = await http.get(Uri.parse(
          '${remoteConfig.getString("serverUrl")}/login/${googleSignInAuth.idToken}'));
      ScaffoldMessenger.of(context).clearSnackBars();
      print(data.body);
      if (data.statusCode == 200) {
        var json = jsonDecode(data.body);
        if (json['success']) {
          var userData = json['user_data'];
          var info = UserInfo(
              gmail: userData['email'],
              tokenId: json['token'],
              picture: userData['picture'],
              id: userData['sub'],
              name: userData['name']);
          print(info);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen(info)),
              (Route<dynamic> route) => false);
          Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
          String topic = stringToBase64Url.encode(info.gmail);
          FirebaseMessaging.instance.deleteToken();
          print(topic.substring(0, topic.length - 1));
          FirebaseMessaging.instance.subscribeToTopic(topic.substring(0, topic.length - 1));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                json['error_message'],
                style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print(data.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No internet connection :(',
              style: fontLoginText.copyWith(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  logout() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication);
}
