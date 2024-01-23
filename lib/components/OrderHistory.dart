import 'package:flutter/material.dart';
import '../models/load_data.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key, Key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
        future: Order.fetchOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: const Text('Đang tải dữ liệu...'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Lỗi: ${snapshot.error}');
          } else {
            List<Order> orders = snapshot.data!;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                Order order = orders[index];
                Map<String, dynamic> data = {
                  'name': order.name,
                  'status': order.status,
                  'productmoney': order.productMoney,
                  'OrderId': order.orderId
                };

                return Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'Trạng thái đơn hàng: ' + data['status'],
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: 115,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                ),
                                child: Image.network(
                                  "",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // khoảng cách ảnh đến tên sản phẩm
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+ ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Giá tiền: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0, // kc bên phải
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 8,
                            child: Row(
                              children: [
                                SizedBox(
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
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          side: const BorderSide(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Xem chi tiết',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width: 10), // Khoảng cách giữa hai nút
                                SizedBox(
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
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          side: const BorderSide(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
