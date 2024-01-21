
import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/ManageProductScreen.dart';
import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key, required this.id});
  final String id;

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageAccountScreen(AdminId:widget.id),
                ),
              );
            },
            child: Container(
              height: 40,
              color:  Colors.pink[50],
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quản lý tài khoản",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageAccountScreen(AdminId:widget.id),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageProductScreen(Id: widget.id),
                ),
              );
            },
            child: Container(
              height: 40,
              color:  Colors.pink[50],
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quản lý sản phẩm",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  IconButton(
                    onPressed: (){
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageProductScreen(Id:widget.id),
                  ),
                 );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}