import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:
            Image.asset('assets/img/background.jpg', fit: BoxFit.fill),
        toolbarHeight: 130,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.account_circle_sharp,
                      size: 150.0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    UserInfoItem(text: 'Nickname:', value: 'super_dragon'),
                    UserInfoItem(text: 'Ngày sinh:', value: '30/12/2002'),
                    UserInfoItem(text: 'Giới tính', value: 'Nam'),
                    UserInfoItem(text: 'Xếp hạng:', value: 'Vàng'),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/myorder');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.shopping_cart_sharp,
                      ),
                      Text(" Đơn hàng của tôi", style: TextStyle(fontSize: 25)),
                      const SizedBox(width: 107),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String text;
  final String value;

  const UserInfoItem({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(' $text', style: const TextStyle(fontSize: 17)),
          const SizedBox(width: 10.0),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        ],
      ),
    );
  }
}
