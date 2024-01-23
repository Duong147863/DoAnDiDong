import 'package:doandidongappthuongmai/components/ListAccountItem.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({Key? key, required this.AdminId}) : super(key: key);
  final String AdminId;
  @override
  State<ManageAccountScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ManageAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  
  List<Map<String, dynamic>> accounts = [];

  @override
  void initState() {
    super.initState();
    loadAccountsWithFalsePermission();
    print("Init state called");
  }
//Load tài khoản có phân quyền user và admin
Future<void> loadAccountsWithFalsePermission() async {
  try {
    DataSnapshot accountsSnapshot = (await _database.child('users').orderByChild('persission').equalTo(false).once()).snapshot;

    if (accountsSnapshot.value != null) {
      Map<String, dynamic>? accountsData = (accountsSnapshot.value as Map?)?.cast<String, dynamic>();
      List<Map<String, dynamic>> filteredAccounts = [];
  
      accountsData?.forEach((userId, userData) {
        String displayname = userData['displayName'] ?? '';
        String email = userData['email'] ?? '';
        //phân quyền
        bool perssion = userData['persission'] ?? false;
        bool status =userData['status'] ?? true;
        if (!perssion) {
          filteredAccounts.add({
            'userId': userId, 
            'displayName': displayname,
            'email': email,
            'status':status
          });
        }
      });
      setState(() {
        accounts = filteredAccounts;
      });
    }
  } catch (e) {
    print("Error loading accounts with false permission: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.pink[50],
        title: Text(
          "Quản lý tài khoản",
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return AccountInfoContainer(
            admin:widget.AdminId,
            displayName: accounts[index]['displayName'] ?? 'N/A',
            email: accounts[index]['email'] ?? 'N/A',
            userId: accounts[index]['userId'] ?? 'N/A',
            status: accounts[index]['status'] ?? 'N/A',
          );
        },
      ),
    );
  }
}
