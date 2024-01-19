import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemProductCart extends StatefulWidget {
  const ItemProductCart({super.key});

  @override
  State<ItemProductCart> createState() => _ItemProductCartState();
}

class _ItemProductCartState extends State<ItemProductCart> {
  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          Radio(value: "", groupValue: "", onChanged: (index){}),
          Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.only(right: 15),
            child: Image.asset("img/boc_rac.jpg"),
          ),
          Padding(
          padding:const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             const Text("Bọc rác LV",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 12, 2, 46)),
              ),
             const Text("99.000 VNĐ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold, 
                color: Color.fromARGB(255, 81, 4, 4)),
              ),
              Row(
                  children: [
                   Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(0),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      ),
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal:5),
                      child: const Text("1",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                    )
                  ],
                ),
            ],
          ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
          ) 
        ],
      );
  }
}


// import 'package:flutter/material.dart';
// import 'package:appiot/model/load_data.dart';
// class EditProfileForm extends StatefulWidget {
//   final User user;
//   final VoidCallback reloadUserDataCallback;
//   const EditProfileForm({Key? key, required this.user, required this.reloadUserDataCallback}) : super(key: key);

//   @override
//   _EditProfileFormState createState() => _EditProfileFormState();
// }

// class _EditProfileFormState extends State<EditProfileForm> {
//   late TextEditingController _usernameController;
//   late TextEditingController _phoneController;
//   late TextEditingController _emailController;

//   @override
//   void initState() {
//     super.initState();
//     _usernameController = TextEditingController(text: widget.user.username);
//     _phoneController = TextEditingController(text: widget.user.phone);
//     _emailController = TextEditingController(text: widget.user.email);
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Profile'),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextField(
//             controller: _usernameController,
//             decoration: InputDecoration(labelText: 'Username'),
//           ),
//           TextField(
//             controller: _phoneController,
//             decoration: InputDecoration(labelText: 'Phone'),
//           ),
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(labelText: 'Email'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             updateUserInformation();
//             Navigator.pop(context);
//             widget.reloadUserDataCallback();
//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
//   }

//   Future<void> updateUserInformation() async {
//     await widget.user.updateInformation(
//       _usernameController.text,
//       _phoneController.text,
//       _emailController.text,
//     ); 
//   }
// }