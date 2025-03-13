import 'package:flutter/material.dart';

import '../../base/base_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        backgroundColor: Colors.white,
        statusBarColor: Colors.white,
        centerTitle: true,
        showTitle: true,
        title: "Chat",
      ),
    );
  }
}
