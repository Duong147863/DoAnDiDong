import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/LoginScreen.dart'; // Import your LoginScreen
import 'package:flutter/material.dart';
import '../models/load_data.dart';

class ProfileScreen extends StatefulWidget {
  final String Id;
  const ProfileScreen({Key? key, required this.Id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   User currentUser =User(name:"", email: "", phone: "", typeaccount: false, status: true, address:"");

  @override
  void initState() {
    super.initState();
    _loadCurrentUser(widget.Id); // Thay "user1" bằng ID hoặc key của người dùng bạn muốn hiển thị
  }

  void _loadCurrentUser(String userId) async {
    try {
      User user = await User.fetchUser(userId);
      setState(() {
        currentUser = user;
      });
    } catch (error) {
      print("Error loading user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: currentUser != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${currentUser.name}'),
                  Text('Email: ${currentUser.email}'),
                  Text('Chức vụ: ${currentUser.typeaccount ? "Admin" : "Người dùng"}'),
                  Text('Số điện thoại: ${currentUser.phone}')
                ],
              )
            : Text('User not found'),
      ),
    );
  }
}
