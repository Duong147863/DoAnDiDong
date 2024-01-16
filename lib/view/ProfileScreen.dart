import 'package:flutter/material.dart';
import '../models/load_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser("user2"); // Thay "user1" bằng ID hoặc key của người dùng bạn muốn hiển thị
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
        child: currentUser != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${currentUser.iduser}'),
                  Text('Name: ${currentUser.name}'),
                  Text('Email: ${currentUser.email}'),
                  // Add more fields as needed
                ],
              )
            : Text('User not found'),
      ),
    );
  }
}
