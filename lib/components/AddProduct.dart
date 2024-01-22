import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/ManageProductScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/load_data.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key, required this.Id});
  final String Id;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? imagePath;
  bool isImageSelected = false;
  String selectedCategoryId = '';
  String? idcat;
  String? encodedImage;
  String? imageData;
  String? idProduct;
  bool isRecommended = false;
  bool isBestSeller = false;
  bool sell = false;
  bool suggets = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _promotionController = TextEditingController();
  final TextEditingController _desciptionController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();

//thanh thông báo
  bool isSnackBarVisible = false;

  void _showSnackBar(String message) {
    if (!isSnackBarVisible) {
      isSnackBarVisible = true;

      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 1), //thời gian hiển thị
            ),
          )
          .closed
          .then((_) {
        //khi hết thời gian hiển thị đóng -> đặt lại giá trị
        isSnackBarVisible = false;
      });
    }
  }

  void configureFirestore() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, // cho phép lưu trữ off
    );
  }

  String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      List.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  Future<void> addProductToFirebase() async {
    final name = _nameController.text;
    final quantity = int.parse(_quantityController.text);
    final price = double.parse(_priceController.text);
    final promotion = double.parse(_promotionController.text);
    final description = _desciptionController.text;
    final producer = _producerController.text;
    String idProduct = generateRandomString(10);

    try {
      DatabaseReference productsRef =
          FirebaseDatabase.instance.ref().child('products');

      String productId = productsRef.push().key!;
      //cho phép tạo một khóa mới cho dữ liệu sản phẩm và trả về một tham chiếu đến vị trí mới được tạo

      Map<String, dynamic> productData = {
        'idproduct': idProduct,
        'name': name,
        'quantity': quantity,
        'price': price,
        'promotion': promotion,
        'description': description,
        'producer': producer,
        'categoryId': selectedCategoryId, // số mã lsp,
        'image': imageData, // link ảnh lưu trữ fire storage
        'sell': sell,
        'suggets': suggets
      };

      productsRef.child(productId).set(productData).then((_) {
        _showSnackBar('Thêm sản phẩm thành công');
      }).catchError((error) {
        _showSnackBar('Thêm sản phẩm thất bại: $error');
      });
    } catch (error) {
      _showSnackBar('Thêm sản phẩm thất bại: $error');
    }

    // Nếu có giảm giá, thêm sản phẩm vào bảng productsale
    // if (promotion > 0) {
    //   DatabaseReference saleProductsRef =
    //       FirebaseDatabase.instance.reference().child('productsales');
    //   String saleProductId = saleProductsRef.push().key!;

    //   Map<String, dynamic> saleProductData = {
    //     'idproduct': idProduct,
    //     'name': name,
    //     'quantity': quantity,
    //     'price': price,
    //     'promotion': promotion,
    //     'description': description,
    //     'producer': producer,
    //     'categoryId': selectedCategoryId, // số mã lsp,
    //     'image': imageData, // link ảnh lưu trữ fire storage
    //   };

    //   saleProductsRef.child(saleProductId).set(saleProductData).then((_) {
    //     _showSnackBar('Thêm sản phẩm giảm giá thành công');
    //   }).catchError((error) {
    //     _showSnackBar('Thêm sản phẩm giảm giá thất bại: $error');
    //   });

    //   // Kiểm tra xem sản phẩm có nên được thêm vào bảng productsuggest hay không
    //   if (isRecommended) {
    //     DatabaseReference suggestProductsRef =
    //         FirebaseDatabase.instance.ref().child('productsuggests');
    //     String suggestProductId = suggestProductsRef.push().key!;

    //     Map<String, dynamic> suggestProductData = {
    //       'idproduct': idProduct,
    //       'name': name,
    //       'quantity': quantity,
    //       'price': price,
    //       'promotion': promotion,
    //       'description': description,
    //       'producer': producer,
    //       'categoryId': selectedCategoryId, // số mã lsp,
    //       'image': imageData, // link ảnh lưu trữ fire storage
    //     };

    //     suggestProductsRef
    //         .child(suggestProductId)
    //         .set(suggestProductData)
    //         .then((_) {
    //       _showSnackBar('Thêm sản phẩm gợi ý thành công');
    //     }).catchError((error) {
    //       _showSnackBar('Thêm sản phẩm gợi ý thất bại: $error');
    //     });
    //   }
    // }

    // Kiểm tra xem sản phẩm có nên được thêm vào bảng productsell hay không
    // if (isBestSeller) {
    //   DatabaseReference sellProductsRef =
    //       FirebaseDatabase.instance.ref().child('productsells');
    //   String sellProductId = sellProductsRef.push().key!;

    //   Map<String, dynamic> sellProductData = {
    //     'idproduct': idProduct,
    //     'name': name,
    //     'quantity': quantity,
    //     'price': price,
    //     'promotion': promotion,
    //     'description': description,
    //     'producer': producer,
    //     'categoryId': selectedCategoryId, // số mã lsp,
    //     'image': imageData, // link ảnh lưu trữ fire storage
    //   };

    //   sellProductsRef.child(sellProductId).set(sellProductData).then((_) {
    //     _showSnackBar('Thêm sản phẩm bán chạy thành công');
    //   }).catchError((error) {
    //     _showSnackBar('Thêm sản phẩm bán chạy thất bại: $error');
    //   });
    // }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // final storageRef = FirebaseStorage.instance.ref();
    if (pickedFile != null) {
      String generateRandomString(int length) {
        const chars =
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        final random = Random();
        return String.fromCharCodes(
          List.generate(
              length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
        );
      }

      idProduct = generateRandomString(10);

      File imageFile = File(pickedFile.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = idProduct!;
      // Sử dụng idProduct làm tên tệp
      Reference reference = storage.ref().child('images/$filename.png');

      // Tải ảnh lên Firebase Storage
      await reference.putData(imageBytes);

      // Lấy URL của ảnh đã tải lên
      String imageUrl = await reference.getDownloadURL();

      setState(() {
        imageData = imageUrl;
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ManageProductScreen(
                        Id: widget.Id,
                      )),
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Quản lý thêm sản phẩm',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
                        ))
                    : IconButton(
                        icon: const Icon(
                          // ảnh mặc định khi chưa có ảnh
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
                        controller: _nameController,
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
                  "Loại sản phẩm: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FutureBuilder<List<Category>>(
                        future: Category.GetCategory(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Category>> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Đã xảy ra lỗi: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text('Không có dữ liệu');
                          }
                          List<Category> categories = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            value: selectedCategoryId.isNotEmpty
                                ? selectedCategoryId
                                : null,
                            items: categories.map((Category category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (String? catgory) {
                              {
                                setState(() {
                                  selectedCategoryId = catgory!;
                                });
                              }
                            },
                          );
                        },
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
                      controller: _quantityController,
                      keyboardType:
                          TextInputType.number, // bàn phím nhập kiểu số
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
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập giá',
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
                  "Giảm giá: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: _promotionController,
                        keyboardType:
                            TextInputType.number, // bàn phím nhập kiểu số
                        validator: (value) {
                          if (value!.isEmpty) {
                            _showSnackBar('Vui lòng nhập giảm giá');
                          }
                          final numericValue = double.tryParse(value);
                          if (numericValue! < 0) {
                            _showSnackBar('Vui lòng nhập giảm giá lớn hơn 0');
                          }
                          return null;
                        },
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập giảm giá',
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
            // Widget Checkbox để chọn xem sản phẩm có nên được thêm vào danh sách gợi ý hay không
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Sản phẩm gợi ý: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          const Spacer(), // tạo khoảng trống
                          Checkbox(
                            value: suggets,
                            onChanged: (bool? newValue) {
                              setState(() {
                                suggets = newValue ?? false;
                              });
                            },
                            checkColor: Colors
                                .white, // Màu của dấu tích khi ô được chọn
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue;
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                        ],
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

            // Widget Checkbox để chọn xem sản phẩm có nên được thêm vào danh sách bán chạy hay không
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                const Text(
                  "Sản phẩm bán chạy: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          const Spacer(), // tạo khoảng trống
                          Checkbox(
                            value: sell,
                            onChanged: (bool? newValue) {
                              setState(() {
                                sell = newValue ?? false;
                              });
                            },
                            checkColor: Colors
                                .white, // Màu của dấu tích khi ô được chọn
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              //fill: xd thuộc tính màu cho wg
                              //resolveWith: định nghĩa 1 thuộc tính màu sắc dựa trên trang thái trả về đt Color
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue;
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                        ],
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
                        controller: _desciptionController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập Thông tin',
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
                  "Nhà sản xuất: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: _producerController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên nhà sản xuất',
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
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isNotEmpty &&
                  selectedCategoryId != '' &&
                  _quantityController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty &&
                  _promotionController.text.isNotEmpty &&
                  _desciptionController.text.isNotEmpty &&
                  _producerController.text.isNotEmpty) {
                //thông báo sl sp
                int quantityNum = int.tryParse(_priceController.text) ?? 0;
                String quantityW = _quantityController.text.toString();
                RegExp letterRegex = RegExp(r'[a-zA-Z]');
                RegExp numRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                if (letterRegex.hasMatch(quantityW)) {
                  return _showSnackBar('số lượng sản phẩm phải là số');
                } else if (numRegex.hasMatch(quantityW)) {
                  return _showSnackBar('số lượng sản phẩm phải là số');
                } else if (quantityNum < 0) {
                  return _showSnackBar('số lượng sản phẩm không thể nhỏ hơn 0');
                }

                //thông báo giá sp
                int priceNum = int.tryParse(_priceController.text) ?? 0;
                String priceW = _quantityController.text.toString();
                if (letterRegex.hasMatch(priceW)) {
                  return _showSnackBar('giá bán sản phẩm phải là số');
                } else if (numRegex.hasMatch(priceW)) {
                  return _showSnackBar('giá bán sản phẩm phải là số');
                } else if (priceNum < 0) {
                  return _showSnackBar('giá bán sản phẩm không thể nhỏ hơn 0');
                }

                //thông báo giảm giá sp
                int proNum = int.tryParse(_promotionController.text) ?? 0;
                String proceW = _promotionController.text.toString();
                if (letterRegex.hasMatch(proceW)) {
                  return _showSnackBar('giá giảm sản phẩm phải là số');
                } else if (numRegex.hasMatch(proceW)) {
                  return _showSnackBar('giá giảm sản phẩm phải là số');
                } else if (proNum < 0) {
                  return _showSnackBar('giá giảm sản phẩm không thể nhỏ hơn 0');
                }

                if (proNum > priceNum) {
                  return _showSnackBar(
                      'giá bán giảm giá phải nhỏ hơn giá bán sản phẩm');
                }
                //thêm sp, thông báo
                addProductToFirebase();
                await initNotifications();

                showAddProductSuccessNotification();
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageProductScreen(Id: widget.Id),
                ),
              ).then((_) {
                // Sau khi thêm/sửa sản phẩm và quay lại, popUntil để quay lại màn hình quản lý sản phẩm
                Navigator.popUntil(context, (route) => route.isFirst);
              });
              } else {
                return _showSnackBar('Vui lòng nhập đầy đủ thông tin sản phẩm');
              }
            }, //hình dạng nút
            style: ElevatedButton.styleFrom(
              elevation: 5, // độ nổi
              backgroundColor: const Color.fromARGB(255, 146, 255, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 90), // chỉnh độ cao nút
            ),
            child: const Text(
              'Thêm sản phẩm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}
