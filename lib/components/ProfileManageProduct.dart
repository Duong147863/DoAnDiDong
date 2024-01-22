import 'dart:convert';
import 'package:doandidongappthuongmai/components/EditProducts.dart';
import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:flutter/material.dart';

import '../models/load_data.dart';

class ProfileManageProduct extends StatefulWidget {
  final String searchQuery;
  final String id;

  const ProfileManageProduct({super.key, required this.searchQuery, required this.id});

  @override
  State<ProfileManageProduct> createState() => _ProfileManageProductState();
}

class _ProfileManageProductState extends State<ProfileManageProduct> {
  void navigateToEditProduct(
      String idpro, String catId, String productId, String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProduct(
          id: widget.id,
          idPro: idpro,
          catId: catId,
          productId: productId,
          image: image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Product.fetchProducts(), // lấy ds sp từ firebase
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: const Text("Dang tải dữ liệu....."),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product> products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              String productId = products[index].idproduct; //lấy id sp
              String catId = products[index].category; //lấy id lsp
              String idpro = products[index].id; //lấy id tên bảng sp
              String image = products[index].image;

              Product product = products[index];
              Map<String, dynamic> data = {
                'name': product.name,
                'price': product.price,
                'quantity': product.quantity,
                'image': product.image,
                'promotion': product.promotion,
              };
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                ),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                          child: Container(
                            height: 130,
                            width: 120,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: data['image'] != null &&
                                    data['image'].isNotEmpty
                                ? Image.network(
                                    data['image'],
                                    fit: BoxFit.fill,
                                  )
                                : const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                            //icon khi dữ liệu ảnh trống
                          ),
                        ),
                        const SizedBox(width: 2), //khoảng cách giữa chữ, ảnh
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10)), //kc bên trên chữ, ô chứa
                              SizedBox(
                                height: 40,
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 2, // Giới hạn số dòng
                                  overflow: TextOverflow
                                      .ellipsis, // Hiển thị dấu chấm elipsis khi quá dài
                                ),
                              ),

                              const SizedBox(height: 3), // kc giữa tên, tiền
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (data['promotion'] != 0)
                                    Stack(
                                      children: [
                                        Text(
                                          '${data['price']} đ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.black,
                                            decorationThickness: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (data['promotion'] == 0)
                                    Stack(
                                      children: [
                                        Text(
                                          '${data['price']} đ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (data['promotion'] != 0)
                                    Stack(
                                      children: [
                                        Text(
                                          '${data['promotion']} đ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (data['promotion'] == 0)
                                    Container(
                                      height: 20,
                                    )
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Số lượng: ${data['quantity']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              onPressed: () => {
                                navigateToEditProduct(
                                    idpro, catId, productId, image)
                                //chuyển đến trang sửa sản phẩm
                              },
                              icon: const Icon(Icons.border_color_rounded),
                              tooltip: 'sửa sản phẩm',
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              onPressed: () => {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Thông báo'),
                                      content: const Text(
                                          'Bạn có chắc muốn xóa sản phẩm này?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                true); // xác nhận xóa trả giá tri về true
                                          },
                                          child: const Text('Xóa'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text('Hủy'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) {
                                  if (value != null && value) {
                                    // Xóa sản phẩm
                                    Product.deleteProduct(idpro);
                                    showDeleteProductSuccessNotification();
                                    setState(() {});
                                  } else {
                                    // Hủy
                                  }
                                })
                              },
                              icon: const Icon(Icons.delete),
                              tooltip: 'xóa sản phẩm',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
