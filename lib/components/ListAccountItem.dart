import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AccountInfoContainer extends StatefulWidget {
  final String displayName;
  final String email;
  final String userId;
  final bool status;
  final String admin;
  const AccountInfoContainer(
      {required this.displayName,
      required this.admin,
      required this.email,
      required this.userId,
      required this.status});

  @override
  _AccountInfoContainerState createState() => _AccountInfoContainerState();
}

class _AccountInfoContainerState extends State<AccountInfoContainer> {
  final _firebaseMessaging = FirebaseMessaging.instance;
  late bool isSwitched = widget.status; //lấy trạng thái 
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  @override
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message,
            style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
        backgroundColor: Colors.pink);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSwitched ? Colors.pink[50] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), 
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isSwitched ? Icons.task_alt : Icons.cancel_outlined,
            color: isSwitched ? Colors.blue : Colors.red,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.displayName}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${widget.email}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Switch(
            value: isSwitched,
            activeColor: Colors.pink,
            onChanged: (value) {
              _showAlertDialog(value);
            },
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(bool newValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _AlertDialog(isSwitched: newValue);
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        _updateAccountStatus(newValue);
      }
    });
  }
  //Cập nhật trạng thái và tạo notification trên firebase
  void _updateAccountStatus(bool updatevalue) async {
    DatabaseReference userReference =
        _databaseReference.child('users').child(widget.userId);
    setState(() {
          isSwitched = updatevalue;
        });
    userReference.update({
      'status': updatevalue,
    });

    if (!updatevalue) {
      // Tài khoản bị khóa và hiển thị thông báo
      initNotifications();
      NotificationOfLockedAccount(widget.displayName);
      NotificationData notificationData = NotificationData(
        AdminId: widget.admin,
        userId: widget.userId,
        title: "Tài khoản bị khóa",
        description: "Tài khoản của ${widget.displayName} đã bị khóa",
        time: DateTime.now(),
      );
      //tạo trường thông báo
      await _databaseReference.child('notifications').push().set({
          'AdminId': notificationData.AdminId,
          'userId': notificationData.userId,
          'title': notificationData.title,
          'description': notificationData.description,
          'time': notificationData.time.millisecondsSinceEpoch,
        }).then((value) {
          print("Data saved successfully!");
        }).catchError((error) {
          print("Failed to save data: $error");
        });

      showSnackBar(context, "Khóa tài khoản");
      // Tạo thông báo và lưu vào Firebase
     
    } else {
      // Tài khoản được mở khóa và hiển thị thông báo
      initNotifications();
      AccountUnlockNotification(widget.displayName);
       NotificationData notificationData = NotificationData(
          AdminId: widget.admin,
          userId: widget.userId,
          title: "Tài khoản được mở khóa",
          description: "Tài khoản của ${widget.displayName} đã được mở khóa",
          time: DateTime.now(),
        );
        //tạo trường thông báo
        await _databaseReference.child('notifications').push().set({
          'AdminId': notificationData.AdminId,
          'userId': notificationData.userId,
          'title': notificationData.title,
          'description': notificationData.description,
          'time': notificationData.time.millisecondsSinceEpoch,
        }).then((value) {
          print("Data saved successfully!");
        }).catchError((error) {
          print("Failed to save data: $error");
        });

      showSnackBar(context, "Mở khóa tài khoản");
      // Tạo thông báo và lưu vào Firebase
    }
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    Key? key,
    required this.isSwitched,
  }) : super(key: key);
  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.notification_important_outlined,
                    color: Colors.black),
                Text("Thông báo"),
              ],
            ),
          ),
        ],
      ),
      content: Text(isSwitched
          ? "Bạn có muốn mở khóa tài khoản này không?"
          : "Bạn có muốn khóa tài khoản này không?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Đồng ý'),
            ),
          ],
        )
      ],
    );
  }
}