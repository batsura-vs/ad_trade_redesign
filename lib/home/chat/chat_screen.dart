import 'dart:async';
import 'dart:convert';
import 'package:ad_trade_redesing/data/config.dart';
import 'package:ad_trade_redesing/data/user_info.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:ad_trade_redesing/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final user;

  const ChatScreen({Key? key, this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  late final _user;
  late UserInfo iUser = widget.user;
  late String chatNow = iUser.gmail;
  late String dropdownValue = chatNow;
  late List<String> chats = [chatNow];
  late Map<String, dynamic> myChat;
  bool wait = false;
  IO.Socket socket = IO.io(
    remoteConfig.getString('httpServerUrl'),
    <String, dynamic>{
      'transports': ['websocket'],
    },
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _user = types.User(
        id: iUser.id, imageUrl: iUser.picture, firstName: iUser.name);
    socket.connect();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void reload() async {
    setState(() {
      wait = true;
    });
    final response = await http.post(
        Uri.parse('${remoteConfig.getString("serverUrl")}/chat'),
        body: jsonEncode({'token': widget.user.tokenId}));
    dynamic js = jsonDecode(response.body);
    final messages;
    if (response.statusCode == 201) {
      myChat = js;
      setState(() {
        chats = js.keys.toList();
      });
      messages = (js[dropdownValue] as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      myChat = {chatNow: js};
      messages = (js as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    setState(() {
      _messages = messages.reversed.toList();
      wait = false;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
    print(remoteConfig.getString("serverUrl"));
    socket.emit('send_message', {
      "token": widget.user.tokenId,
      "message": textMessage.toJson(),
      "to": chatNow,
    });
    // http.post(
    //     Uri.parse(
    //         '${remoteConfig.getString("serverUrl")}/send_message/$chatNow'),
    //     body: jsonEncode(
    //         {'token': widget.user.tokenId, 'message': textMessage.toJson()}));
    // _addMessage(textMessage);
  }

  void _loadMessages() async {
    print(remoteConfig.getString("serverUrl"));
    final response = await http.post(
        Uri.parse('${remoteConfig.getString("serverUrl")}/chat'),
        body: jsonEncode({'token': widget.user.tokenId}));
    dynamic js = jsonDecode(response.body);
    final messages;
    if (response.statusCode == 201) {
      myChat = js;
      setState(() {
        chats = js.keys.toList();
      });
      messages = (myChat[dropdownValue] as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      myChat = {chatNow: js};
      messages = (js as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    setState(() {
      _messages = messages.reversed.toList();
    });
    socket.on(chatNow, (data) {
      print(data);
      if (data['to'] == chatNow && data['from'] != iUser.gmail) {
        print(data['to']);

        _addMessage(
          types.Message.fromJson(data['message']),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorGray2,
        title: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(color: colorText),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          dropdownColor: colorGray3,
          onChanged: (String? newValue) {
            dropdownValue = newValue!;
            setState(() {
              reload();
              chatNow = dropdownValue;
              _messages = (myChat[dropdownValue]! as List)
                  .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
                  .toList()
                  .reversed
                  .toList();
            });
            socket.clearListeners();
            print(chatNow);
            socket.on(chatNow, (data) {
              print(data);
              if (data['to'] == chatNow && data['from'] != iUser.gmail) {
                print(data['to']);

                _addMessage(
                  types.Message.fromJson(data['message']),
                );
              }
            });
          },
          items: chats.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          wait
              ? Center(child: CircularProgressIndicator())
              : OutlineIconButton(
                  color: outlineBorderColor,
                  onTap: reload,
                  text: '',
                  icon: Icons.refresh,
                  styleText: fontLoginText,
                ),
          OutlineIconButton(
            color: outlineBorderColor,
            onTap: () {
              http.post(
                  Uri.parse(
                      '${remoteConfig.getString("serverUrl")}/close_ticket/$chatNow'),
                  body: jsonEncode({'token': widget.user.tokenId}));
              setState(() {
                _messages = [];
              });
            },
            text: remoteConfig.getString('close_chat'),
            icon: Icons.clear,
            styleText: fontLoginText,
          ),
        ],
      ),
      body: Chat(
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DarkChatTheme(),
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }
}
