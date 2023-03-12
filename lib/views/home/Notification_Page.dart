import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String? payload;
  const NotificationPage({Key? key, this.payload}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.payload ?? "empty"),
      ),
    );
  }
}
