import 'package:flutter/material.dart';

import '../../base/base_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        backgroundColor: Colors.white,
        statusBarColor: Colors.white,
        centerTitle: true,
        showTitle: true,
        title: "Notifications",
      ),
    );
  }
}
