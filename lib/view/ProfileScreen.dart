import 'package:doandidongappthuongmai/view/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
void showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditProfileScreen();
      },
    );
  }
class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath = null;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _clearImage() {
    setState(() {
      imagePath = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        toolbarHeight: 40,
        backgroundColor:  Colors.pink[50],
        title: const Text('Thông tin cá nhân',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
        actions: [
          const Padding(padding: EdgeInsets.all(5)),
          IconButton(
          onPressed: (){
           showEditProfileDialog(context);
          },
          icon: const Icon(Icons.settings,color: Color.fromARGB(255, 12, 2, 46))),
          IconButton(
          onPressed: (){},
          icon: const Icon(Icons.exit_to_app_rounded,color: Color.fromARGB(255, 12, 2, 46)))
        ],
      ),
      body: Column(
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
                //border: Border.all(width: 1, color: Colors.grey),
              ),
              child: GestureDetector(
                onTap: () {
                  if (imagePath != null) {
                    _pickImage();
                  }
                },
                child: imagePath != null
                    ? Container(
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(imagePath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.image,
                          size: 50,
                        ),
                        onPressed: _pickImage,
                      ),
              ),
            ),
              // Image(
              //   height: MediaQuery.of(context).size.height/3,
              //   fit: BoxFit.cover,
              //   image: AssetImage("img/anhnen.jpg"),
              // ),
              const Positioned(
                bottom: -70.0,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("img/avt.jpg"),
              ))
          ],
        ),
        const SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children:  const [
                  Text('Họ&Tên: ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                  Text('Trương Công Mới',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text('Chức vụ: ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                  Text('Admin',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text('SĐT: ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                  Text('0123456789',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text('Địa chỉ: ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
                  Text('1A/25 Nguyễn Văn Linh, Q7, tp.HCM',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),softWrap: true,),
                ],
              ),
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

        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            height: 30,
            color:  Colors.pink[50],
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Quản lý tài khoản",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_forward_ios_sharp,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
              ],
            ),
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
                const Text("Quản lý sản phẩm",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_forward_ios_sharp,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
              ],
            ),
          ),
        ),

        
      ],
    ),
    );
  }
  
}
