import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/OrderHistory.dart';

import '../components/PurchasedProduct.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Xử lý logic tương ứng với mỗi tab
    if (_selectedIndex == 0) {
      // Xử lý khi chọn tab 0
    } else if (_selectedIndex == 1) {
      Navigator.pushNamed(context, '/O');
      // Xử lý khi chọn tab 1
    } else if (_selectedIndex == 2) {
      // Xử lý khi chọn tab 2
    }
  }

  bool isPart1Selected = true;
  bool isPart2Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        title: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white, // Màu nền khung tìm kiếm
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.white)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Căn chỉnh các widget con theo chiều ngang
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.grey, // Màu biểu tượng tìm kiếm
                onPressed: () {
                  // Xử lý khi nhấn vào Icon shop
                },
              ),
              const SizedBox(
                width: 2,
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Tìm sản phẩm',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: Colors.pink[50], // Màu nền Icon
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                // Xử lý khi nhấn vào Icon shop
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // Xử lý khi nhấn vào nút quay lại
                },
              ),
              const Text(
                'Đơn hàng của tôi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 1,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ],
          ),
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
