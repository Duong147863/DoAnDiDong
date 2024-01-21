import 'package:flutter/material.dart';

import '../models/load_data.dart';

class PurchasedProduct extends StatefulWidget {
  const PurchasedProduct({Key? key}) : super(key: key);

  @override
  State<PurchasedProduct> createState() => _PurchasedProductState();
}

class _PurchasedProductState extends State<PurchasedProduct> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: FirebaseHelper.fetchOrders(),
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị màn hình chờ loading khi dữ liệu đang được tải
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Xử lý lỗi nếu có
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Xử lý trường hợp không có dữ liệu
          return Text('No data available');
        } else {
          // Hiển thị dữ liệu trong ListView.builder
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Order order = snapshot.data![index];
              OrderProduct product = order
                  .products[0]; // Giả sử chỉ có một sản phẩm trong đơn hàng

              return Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Image.asset(
                            'assets/img/nuocruachen.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " product.productName",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'đ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 8,
                      right: 12,
                      child: SizedBox(
                        width: 100,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nhấn
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                                side: const BorderSide(
                                    color: Colors.black, width: 1.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Mua lại',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
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
