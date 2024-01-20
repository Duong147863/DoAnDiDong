import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
import '../components/ProfileManageProduct.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NotificationListener(
                  child: Text(''),
                )),
      );
    } else if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Xử lý khi nhấn vào nút quay lại
            Navigator.pushNamed(context, '/profile');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Quản lý sản phẩm',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 6), // Khoảng cách viền
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền khung tìm kiếm
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black), // Màu viền xám
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: 'Tìm sản phẩm',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      //chuyển hướng thêm sản phẩm
                      Navigator.pushNamed(context, '/addpro');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 146, 255, 208),
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: Colors.grey), // Kẻ viền xám
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      'Thêm sản phẩm',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: ProfileManageProduct(
                searchQuery:
                    searchQuery, // Truyền thông tin tìm kiếm vào ProfileManageProduct
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
