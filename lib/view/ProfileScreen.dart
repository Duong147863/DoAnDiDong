import 'dart:convert';
import 'dart:io';
import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/LoginScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileFrom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/load_data.dart';
import 'EditProfileFrom.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:doandidongappthuongmai/components/Profile.dart';
class ProfileScreen extends StatefulWidget {
  final String Id;
  const ProfileScreen({Key? key, required this.Id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
  

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseReference userReference;
  late Users currentUser;

  @override
  void initState() {
    super.initState();
    userReference = FirebaseDatabase.instance.ref().child(widget.Id);
    _loadCurrentUser(widget.Id); // Thay "user1" bằng ID hoặc key của người dùng bạn muốn hiển thị
  }

  void reloadUser()
  {
    _loadCurrentUser(widget.Id);
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

  String? imageData;
  String? imagePath;
  String? encodedImage;

  Future<void> _pickImageNen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      encodedImage = base64Encode(imageBytes);

      setState(() {
        // Cập nhật trạng thái widget nếu cần thiết
        imageData = encodedImage;
        imagePath = pickedFile.path;
      });
    }
  }
  void showEditProfileDialog(BuildContext context, Users user,String id) {
  showDialog(
    context: context,
    builder: (context) {
      return EditProfileFrom(user: user,keyId:widget.Id, reloadUserDataCallback: reloadUser);
    },
  );
}
void _updateImage(String imagePath, Users user) async {
    user.image = imagePath;
    await userReference.child(widget.Id).update({'image': imagePath});
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    Users user = currentUser;
    return Scaffold(
      appBar:
      AppBar(
        toolbarHeight: 40,
        backgroundColor:  Colors.pink[50],
        title: const Text('Thông tin cá nhân',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
        actions: [
           Padding(padding: EdgeInsets.all(5)),
          IconButton(
          onPressed: (){
            showEditProfileDialog(context, currentUser, widget.Id);
          },
          icon: const Icon(Icons.settings,color: Color.fromARGB(255, 12, 2, 46))),
          IconButton(
          onPressed: (){},
          icon: const Icon(Icons.exit_to_app_rounded,color: Color.fromARGB(255, 12, 2, 46)))
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
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: imagePath != null
                    ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(currentUser.imageBackground),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : IconButton(
                        icon:  Icon(
                          Icons.image,
                          size: 50,
                        ),
                        onPressed: _pickImageNen,
                      ),
              ),
            ),
              Image(
                height: MediaQuery.of(context).size.height/3,
                fit: BoxFit.cover,
                image: AssetImage(currentUser.imageBackground),
              ),
              Positioned(
                bottom: -70.0,
                child:  InkWell(
                  onTap: () {
                    _pickImage(user);
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
              const SizedBox(height: 10),
              Text('Họ&Tên: ${currentUser.name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
              const SizedBox(height: 10),
              Text('Chức vụ: ${currentUser.typeaccount? "Admin":"Người dùng" }',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),

              const SizedBox(height: 10),
              Text('SĐT: ${currentUser.phone}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
              SizedBox(height: 10),
              Row(
                children: [
                Expanded(
                child: Text('Địa chỉ: ${currentUser.address}',
                style: TextStyle(fontSize: 15,
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
          child: Container(
            height: 30,
            color:  Colors.pink[50],
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Đơn hàng của tôi",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_forward_ios_sharp,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
              ],
            ),
          ),
        ),
        if(currentUser.typeaccount== true)
        ProfileAdmin()
      ],
    ),
        ],
      ),
    );
  }
  Future<void> _pickImage(Users user) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _updateImage(pickedFile.path, user);
    }
  }
}
