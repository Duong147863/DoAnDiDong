import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/NotificationScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key,required this.userId});
   final String userId;
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedScreen = 0;      // mặc định là trang chủ (MainScreen)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(        //IndexedStack được sử dụng để hiển thị một trong ba trang tương ứng với chỉ mục được chọn
        children: [
          MainScreen(Id: widget.userId,),
          NotificationScreen(userId: widget.userId,),
          ProfileScreen(Id: widget.userId,)
        ],
        index: _selectedScreen,
      ),
     bottomNavigationBar:BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cá nhân',
          ),
        ],
        backgroundColor: Colors.pink[50],
        currentIndex:_selectedScreen,
        selectedItemColor: Colors.red,
        onTap: (value) {
          if (value != _selectedScreen) {
            setState(() {
             _selectedScreen = value;
            });
          }
        },
      ),
      
    );
  }
}