import 'package:doandidongappthuongmai/components/AddProduct.dart';
import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
import '../components/ProfileManageProduct.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key, required this.Id});
  final String Id;

  @override
  State<ManageProductScreen> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProductScreen> {
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], 
        title: Center(child: Text("Quản lý sản phẩm",style: TextStyle(color: Colors.black, fontSize: 25),)),
        iconTheme: const IconThemeData(color: Colors.black),   
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
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduct(Id: widget.Id,),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 146, 255, 208),
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: Colors.grey), // Kẻ viền xám
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text('Thêm sản phẩm',
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
                id: widget.Id,
                searchQuery:searchController.text // Truyền thông tin tìm kiếm vào ProfileManageProduct
              ),
            ),
          )
        ],
      ),
     
    );
  }
}
