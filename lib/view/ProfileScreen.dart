import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key,required this.userId});
   final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset('assets/img/background.jpg', fit: BoxFit.fill),
        toolbarHeight: 130,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("hahahaa1 $userId"),
          TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ManageScreen()));
      },
      child: Text("Quản lí tài khoản")
    )
        ],
      )
    );
  }
}


