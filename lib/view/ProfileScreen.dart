import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/LoginScreen.dart'; // Import your LoginScreen
import 'package:flutter/material.dart';
import 'package:doandidongappthuongmai/components/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.userId});

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
            onPressed: () {
              _signOut(context); // Call the sign-out method
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("hahahaa1 $userId"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageScreen()),
              );
            },
            child: Text("Quản lí tài khoản"),
          )
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    FirebaseAuthService authService = FirebaseAuthService();

    try {
      await authService.signOut(); // Call the sign-out method

      // Navigate back to the LoginScreen and clear the stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      print("Error during sign out: $e");
      // Handle any error during sign-out
    }
  }
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Existing methods...

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Error during sign out: $e");
      throw e; // You may want to handle the error or rethrow it based on your needs
    }
  }

  // Other methods...
}
