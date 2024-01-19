import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController= TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller:_usernameController ,
            decoration: InputDecoration(labelText: 'Họ&Tên'),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'SĐT '),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Địa chỉ'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // updateUserInformation();
            // Navigator.pop(context);
            // widget.reloadUserDataCallback();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}