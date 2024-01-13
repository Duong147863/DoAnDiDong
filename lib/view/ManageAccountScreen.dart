import 'package:doandidongappthuongmai/components/ListAccountItem.dart';
import 'package:flutter/material.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  State<ManageScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ManageScreen> {
  List<Map<String, dynamic>> accounts = [
    {'name': 'Duy', 'email': 'duy@gmail.com'},
    {'name': 'Tới', 'email': 'toi@gmail.com'},
    {'name': 'Dương', 'email': 'duong@gmail.com'},
    {'name': 'Mới', 'email': 'moi@gmail.com'},
    {'name': 'Olala', 'email': 'Olala@gmail.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(
          "Quản lý tài khoản",
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return AccountInfoContainer(
                  name: accounts[index]['name'],
                  email: accounts[index]['email'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:doandidongappthuongmai/components/ListAccountItem.dart';
import 'package:flutter/material.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  List<Map<String, dynamic>> accounts = [
    {'name': 'Duy', 'email': 'duy@gmail.com'},
    {'name': 'Tới', 'email': 'toi@gmail.com'},
    {'name': 'Dương', 'email': 'duong@gmail.com'},
    {'name': 'Mới', 'email': 'moi@gmail.com'},
    {'name': 'Olala', 'email': 'Olala@gmail.com'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[50],
          title: Text(
            "Quản lý tài khoản",
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  return AccountInfoContainer(
                    name: accounts[index]['name'],
                    email: accounts[index]['email'],
                  );
                },
              ),
            ],
          ),
        ));
  }
}
