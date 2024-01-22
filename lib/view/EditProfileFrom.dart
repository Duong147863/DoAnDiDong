import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';

class EditProfileFrom extends StatefulWidget {
  final Users user;
  final String keyId;
  final VoidCallback reloadUserDataCallback;
  const EditProfileFrom({Key? key, required this.user, required this.keyId, required this.reloadUserDataCallback}) : super(key: key);

  @override
  
  State<EditProfileFrom> createState() => _EditProfileFromState();
}

class _EditProfileFromState extends State<EditProfileFrom> {
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _addressController = TextEditingController(text: widget.user.address);
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
   Future<void> updateUserInformation(String id) async {  
          await widget.user.updateInformation(
            _usernameController.text,
            _phoneController.text,
            _addressController.text,
            id,
          );
          print("User information updated successfully!");
    }
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
            controller: _addressController,
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
            updateUserInformation(widget.keyId);
            Navigator.pop(context);
            widget.reloadUserDataCallback();
            initNotifications();
            showEditProfileNotification();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
  
}
