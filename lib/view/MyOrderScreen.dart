import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/OrderHistory.dart';
import '../components/PurchasedProduct.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key, required this.id});
  final String id;

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MainScreen()),
      // );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NotificationListener(
                  child: Text(''),
                ) //chuyển đến giỏ hàng
            ),
      );
    } else if (_selectedIndex == 2) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => ProfileScreen() //chuyển đến giỏ hàng
      //       ),
      // );
    }
  }

  bool isPart1Selected = true;
  bool isPart2Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        title: Center(child: Text("Đơn hàng của tôi",style: TextStyle(color: Colors.black, fontSize: 25),)),
        iconTheme: const IconThemeData(color: Colors.black),   
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isPart1Selected = true;
                        isPart2Selected = false;
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: isPart1Selected
                            ? Color.fromARGB(255, 146, 255, 208)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(0), // hình dạng khung
                        )),
                    child: const Text(
                      'Sản phẩm từng mua',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.grey, // Màu viền xám
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isPart1Selected = false;
                        isPart2Selected = true;
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: isPart2Selected
                            ? Color.fromARGB(255, 146, 255, 208)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    child: const Text(
                      'Lịch sử đơn hàng',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Viền xám
                ),
                child: isPart1Selected
                    ? const PurchasedProduct()
                    : const OrderHistory()),
          ),
        ],
      ),
     
    );
  }
}
