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
  late Users currentUser=Users(name: "", email: "", phone: "", typeaccount: true, status: true, address: "", image: "", imageBackground: "");

  @override
  void initState() {
    super.initState();
    userReference = FirebaseDatabase.instance.ref().child(widget.Id);
    _loadCurrentUser(widget.Id); // Thay "user1" bằng ID hoặc key của người dùng bạn muốn hiển thị
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

 
  void showEditProfileDialog(BuildContext context, Users user,String id) {
  showDialog(
    context: context,
    builder: (context) {
      return EditProfileFrom(user: currentUser,keyId:widget.Id, reloadUserDataCallback: reloadUser);
    },
  );
}
Future<void> updateImage(String imagePath, String id) async {
  // Kiểm tra xem tệp tin có tồn tại không
  if (File(imagePath).existsSync()) {
    DatabaseReference userReference = FirebaseDatabase.instance.ref().child('users').child(id);
    await userReference.update({
      'image': imagePath,
    });
  } else {
    print('Tệp tin không tồn tại: $imagePath');
  }
}
  @override
  Widget build(BuildContext context) {
    Users user = currentUser;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor:  Colors.pink[50],
        title: const Text('Thông tin cá nhân',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
        actions: [
           Padding(padding: EdgeInsets.all(5)),
          IconButton(
          onPressed: (){
            showEditProfileDialog(context, currentUser, widget.Id);
          },
          icon: const Icon(Icons.settings,color: Colors.red)),
          IconButton(
          onPressed: (){
           Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>LoginScreen()),
              (route) => false,
            );
   
          },
          icon: const Icon(Icons.exit_to_app_rounded,color: Colors.red))
        ],
      ),
      body: ListView(
        children: [
          Column(
          children:<Widget> [
          Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
              Container(
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  
                },
                // child: imagePath != null
                //     ? Container(
                //           height: MediaQuery.of(context).size.height / 3,
                //           width: MediaQuery.of(context).size.width,
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage(currentUser.imageBackground),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         )
                //       : IconButton(
                //         icon:  Icon(
                //           Icons.image,
                //           size: 50,
                //         ),
                //         onPressed: (){},
                //       ),
              ),
            ),
              // Image(
              //   height: MediaQuery.of(context).size.height/3,
              //   fit: BoxFit.fitWidth,
              //   image: AssetImage(currentUser.imageBackground),
              // ),
              Positioned(
                bottom: -70.0,
                child:  InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: DisplayImage(
                    imagePath: user.image,
                    onPressed: () {
                  
                    },
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
              Text('Họ&Tên: ${currentUser.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
              const SizedBox(height: 10),
              Text('Chức vụ: ${currentUser.typeaccount? "Admin":"Người dùng" }',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
              const SizedBox(height: 10),
              Text('SĐT: ${currentUser.phone}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
              SizedBox(height: 10),
              Row(
                children: [
                Expanded(
                child: Text('Địa chỉ: ${currentUser.address}',
                style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),
                softWrap: true,
                maxLines: 3
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
                          builder: (context) => MyOrder(id: widget.Id,),
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
        if(currentUser.typeaccount== true)
         ProfileAdmin(id: widget.Id)
      ],
    ),
        ],
      ),
    );
  }
  Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Cập nhật đường dẫn ảnh trên Firebase
    await updateImage(pickedFile.path, widget.Id);

    // Gọi setState để widget được tái tạo và hiển thị đường dẫn ảnh mới
    setState(() {
      currentUser.image = pickedFile.path;
    });
  }
}
}