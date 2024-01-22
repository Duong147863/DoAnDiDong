import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doandidongappthuongmai/view/ManageProductScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/load_data.dart';
import '../models/local_notification.dart';

class EditProduct extends StatefulWidget {
  final String idPro;
  final String catId;
  final String productId;
  final String image;
  final String id;

  const EditProduct(
      {Key? key,
      required this.id,
      required this.idPro,
      required this.catId,
      required this.productId,
      required this.image})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? imagePath;
  bool isImageSelected = false;
  String selectedCategoryId = '';
  String? idProduct;
  String? imageData;
  bool isSellProducts = false;
  bool isSuggestedProducts = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _promotionController = TextEditingController();
  final TextEditingController _desciptionController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();

  Future<void> fetchProduct() async {
    //load các thông tin của sản phẩm
    List<Product> products = await Product.fetchProducts();

    for (Product product in products) {
      if (product.id == widget.idPro) {
        setState(() {
          // gán giá trị lại các thông tin hiển thị
          imageData = product.image;
          _nameController.text = product.name;
          _quantityController.text = product.quantity.toString();
          _priceController.text = product.price.toString();
          _promotionController.text = product.promotion.toString();
          _desciptionController.text = product.description;
          _producerController.text = product.producer;
          final selectedCategoryId = widget.catId;
          isSellProducts = product.sell ;
          isSuggestedProducts =product.suggest;
        });
        break;
      }
    }
  }

  void configureFirestore() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled:
          true, // cho phép lưu trữ off : true cho phép bạn truy cập vào dữ liệu Firestore ngay cả khi không có kết nối internet
      // Firestore sẽ tự động đồng bộ dữ liệu khi có kết nối internet trở lại.
    );

    // Tải thông tin sản phẩm từ cơ sở dữ liệu Firebase
    DatabaseReference productRef = FirebaseDatabase.instance
        .reference()
        .child('products')
        .child(widget.idPro);

    productRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map? productData = snapshot.value as Map<dynamic, dynamic>?;

        setState(() {
          _nameController.text = productData?['name'];
          _quantityController.text = productData!['quantity'].toString();
          _priceController.text = productData['price'].toString();
          _promotionController.text = productData['promotion'].toString();
          _desciptionController.text = productData['description'];
          _producerController.text = productData['producer'];
          selectedCategoryId = productData['categoryId'];
          imageData = productData['image'];
        });
      }
    }).catchError((error) {
      _showSnackBar('Lỗi khi tải thông tin sản phẩm: $error');
    });
  }

  void updateProductInFirebase(String productId) {
    final name = _nameController.text;
    final quantity = int.parse(_quantityController.text);
    final price = double.parse(_priceController.text);
    final promotion = double.parse(_promotionController.text);
    final description = _desciptionController.text;
    final producer = _producerController.text;
    final image = imageData; // Thay thế bằng đường dẫn hình ảnh
    bool valueSaleProducts = isSellProducts;
    bool valueSuggestedProduts = isSuggestedProducts;

    try {
      DatabaseReference productsRef =
          FirebaseDatabase.instance.reference().child('products');

      Map<String, dynamic> productData = {
        // 'idproduct': widget.productId,
        'name': name,
        'quantity': quantity,
        'price': price,
        'promotion': promotion,
        'description': description,
        'producer': producer,
        'categoryId': selectedCategoryId,
        'image': image,
        'sell': valueSaleProducts,
        'suggest': valueSuggestedProduts,
      };

      productsRef.child(widget.idPro).update(productData).then((_) {
        _showSnackBar('Cập nhật thông tin sản phẩm thành công');
      }).catchError((error) {
        _showSnackBar('Cập nhật thất bại : $error');
      });
    } catch (error) {
      _showSnackBar('Cập nhật thất bại : $error');
    }
  }

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // final storageRef = FirebaseStorage.instance.ref();

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = widget.idPro;
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
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    // final String  productId  = ModalRoute.of(context)!Settings.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Màu nền hồng nhạt
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true, // căn giữa tiêu đề theo chiều ngang
        title: const Text(
          'Quản lý sửa thông tin sản phẩm',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
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
                child: widget.image.isNotEmpty
                    ? SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: imageData == null
                            ? InkWell(
                                //  bao bọc đối tướng
                                onTap: () {
                                  _pickImage();
                                },
                                child: Image.network(
                                  widget.image,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Image.network(
                                  imageData.toString(),
                                  fit: BoxFit.fill,
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

                          // lấy id của loại sản phẩm
                          List<Category> categories = snapshot.data!;
                          // categories.map((Category category) {
                          //   idCategory = category.id;
                          // });

                          return DropdownButtonFormField<String>(
                            value: widget.catId.isNotEmpty
                                ? widget.catId
                                : null, // lấy id sp đã chọn để hiển thị tên lsp
                            items: categories.map((Category category) {
                              return DropdownMenuItem<String>(
                                value: category.id, //giá trị lsp
                                child: Text(category.name), //tên lsp hiển thị
                              );
                            }).toList(),
                            onChanged: (String? categoryId) {
                              if (categoryId != null) {
                                setState(() {
                                  selectedCategoryId = categoryId;
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
                            value: isSuggestedProducts,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isSuggestedProducts = newValue ?? false;
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
                            value: isSellProducts,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isSellProducts = newValue ?? false;
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
                updateProductInFirebase(widget.productId);
                await initNotifications();
                showEditProductSuccessNotification();
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageProductScreen(Id: widget.id,),
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
                  vertical: 13,
                  horizontal: 0), // chỉnh độ cao nút kc bề ngang chữ
            ),
            child: const Text(
              'Cập nhật thông tin sản phẩm',
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
