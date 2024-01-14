import 'package:flutter/material.dart';

class ProfileManageProduct extends StatefulWidget {
  const ProfileManageProduct({super.key});

  @override
  State<ProfileManageProduct> createState() => _ProfileManageProductState();
}

class _ProfileManageProductState extends State<ProfileManageProduct> {
  @override
  Widget build(BuildContext context) {
    int count = 10;
    void performAction() {
      setState(() {
        count -= 1;
      });
    }

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
                    padding: EdgeInsets.all(10), // Khoảng cách xung quanh ảnh
                    child: Container(
                      height: 120,
                      width: 115,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                      ),
                      child: Image.asset(
                        'assets/img/nuocruachen.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // khoảng cách ảnh đến tên sản phẩm
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nước rửa chén Lix siêu sạch hương chanh túi 3.43 lít',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '55.000đ',
                              style: TextStyle(
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
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/edit')},
                        icon: const Icon(Icons.border_color_rounded),
                        tooltip: 'sửa sản phẩm',
                      ),
                    ),
                    const SizedBox(width: 10), // Khoảng cách giữa hai nút
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
                                          true); // Đóng hộp thoại và trả về giá trị "true"
                                    },
                                    child: const Text('Xóa'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Đóng hộp thoại và trả về giá trị "false"
                                    },
                                    child: const Text('Hủy'),
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            if (value != null && value) {
                              performAction();
                              // Xóa sản phẩm
                            } else {
                              //Hủy
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
}
