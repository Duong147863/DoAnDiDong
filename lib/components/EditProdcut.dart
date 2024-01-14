import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? imagePath = null;
  bool isImageSelected = false;
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
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Quản lý sửa thông tin sản phẩm',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: GestureDetector(
                onTap: () {
                  if (imagePath != null) {
                    _pickImage();
                  }
                },
                child: imagePath != null
                    ? Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(imagePath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.image,
                          size: 50,
                        ),
                        onPressed: _pickImage,
                      ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Tên sản phẩm: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên sản phẩm',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Số lượng: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập số lượng',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "giá bán: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập giá sản phẩm',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Thông tin sản phẩm: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'NhậpThông tin sản phẩm',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Ghi chú: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[100], // Màu nền xám nhạt
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút
          },
          style: ElevatedButton.styleFrom(
            elevation: 5, // độ nổi
            backgroundColor: const Color.fromARGB(255, 146, 255, 208),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text(
            'Cập nhật thông tin sản phẩm',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
