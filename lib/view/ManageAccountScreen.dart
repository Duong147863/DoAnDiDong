import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/productManagementComponent.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Xử lý khi nhấn vào nút quay lại
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
                    onPressed: () {
                      // Xử lý khi nhấn vào Icon tìm kiếm
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Expanded(
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
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
                      Navigator.pushNamed(context, '/add');
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
              child: const ProductManagementComponent(),
            ),
          ),
        ],
      ),
    );
  }
}
