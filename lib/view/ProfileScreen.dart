import 'dart:io';

import 'package:doandidongappthuongmai/view/LoginScreen.dart';
import 'package:doandidongappthuongmai/view/MyOrderScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileFrom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/load_data.dart';
import 'EditProfileFrom.dart';
import 'package:doandidongappthuongmai/components/Profile.dart';

class ProfileScreen extends StatefulWidget {
  final String Id;
  const ProfileScreen({Key? key, required this.Id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseReference userReference;
  Users? currentUser;

  void _loadCurrentUser(String userId) async {
    try {
      Users user = await Users.fetchUser(userId);
      setState(() {
        currentUser = user;
      });
    } catch (error) {
      print("Error loading user data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    userReference = FirebaseDatabase.instance.ref().child(widget.Id);
    _loadCurrentUser(widget.Id);
  }

  void reloadUser() async {
    try {
      Users user = await Users.fetchUser(widget.Id);
      setState(() {
        currentUser = user;
      });
    } catch (error) {
      print("Error loading user data: $error");
    }
  }

  void showEditProfileDialog(BuildContext context, Users user, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return EditProfileFrom(
            user: currentUser!, keyId: widget.Id, reloadUserDataCallback: reloadUser);
      },
    );
  }

  Future<void> updateImage(String imagePath, String id) async {
    if (File(imagePath).existsSync()) {
      DatabaseReference userReference =
          FirebaseDatabase.instance.ref().child('users').child(id);
      await userReference.update({
        'image': imagePath,
      });

      // Cập nhật đường dẫn ảnh trực tiếp trong đối tượng currentUser
      setState(() {
        currentUser!.image = imagePath;
      });
    } else {
      print('Tệp tin không tồn tại: $imagePath');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      // Trường hợp currentUser chưa được gán giá trị
      return CircularProgressIndicator(); // hoặc widget loading khác
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.pink[50],
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 2, 46)),
        ),
        actions: [
          Padding(padding: EdgeInsets.all(5)),
          IconButton(
              onPressed: () {
                showEditProfileDialog(context, currentUser!, widget.Id);
              },
              icon: const Icon(Icons.settings, color: Colors.red)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.exit_to_app_rounded, color: Colors.red))
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image(
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/doandidong-a3982.appspot.com/o/image%2Fbackground.jpg?alt=media&token=7ba6adf0-e1c6-43a9-bae8-94fb6f05a186')),
                  ),
                  Positioned(
                    bottom: -70.0,
                    child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: DisplayImage(
                        imagePath: currentUser!.image,
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text('Họ&Tên: ${currentUser!.name}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 2, 46))),
                    const SizedBox(height: 10),
                    Text(
                        'Chức vụ: ${currentUser!.typeaccount ? "Admin" : "Người dùng" }',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 2, 46))),
                    const SizedBox(height: 10),
                    Text('SĐT: ${currentUser!.phone}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 2, 46))),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Địa chỉ: ${currentUser!.address}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 12, 2, 46)),
                            softWrap: true,
                            maxLines: 3,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyOrder(id: widget.Id),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    color: Colors.pink[50],
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Đơn hàng của tôi",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyOrder(
                                  id: widget.Id,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Color.fromARGB(255, 12, 2, 46),
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (currentUser!.typeaccount == true) ProfileAdmin(id: widget.Id)
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await updateImage(pickedFile.path, widget.Id);

      // Gọi reloadUser để cập nhật dữ liệu người dùng
      reloadUser();
    }
  }
}
