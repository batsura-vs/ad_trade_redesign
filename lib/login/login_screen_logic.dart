import 'package:ad_trade_redesing/data/user_info.dart';
import 'package:ad_trade_redesing/home/home_screen.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

class LoginScreenLogic extends State<LoginScreen> {
  late GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Firebase.initializeApp();
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    var googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAccount!.authentication;
    var data = await http.get(Uri.parse(
        'http://192.168.1.148:4999/login/${googleSignInAuth.idToken}'));
    ScaffoldMessenger.of(context).clearSnackBars();
    if (data.statusCode == 200) {
      var json = jsonDecode(data.body);
      if (json['success']) {
        var userData = json['user_data'];
        var info = UserInfo(
            gmail: userData['email'],
            tokenId: json['token'],
            picture: userData['picture'],
            id: userData['sub'],
            name: userData['name']
        );
        print(info);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomeScreen(info)), (Route<dynamic> route) => false);
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

  logout() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
