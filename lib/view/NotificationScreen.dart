import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: const Text("Thông báo",style: TextStyle(color: Colors.black, fontSize: 25),),
        leading: Icon(Icons.notifications),
        iconTheme: const IconThemeData(color: Colors.black), 
      ),
    );
  }
}