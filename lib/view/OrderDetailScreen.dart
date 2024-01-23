
import 'package:doandidongappthuongmai/components/Navigation.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderDetails orderdetailinfo;
  final String Id;
  const OrderDetailScreen({super.key, required this.orderdetailinfo, required this.Id});
  
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
  }
  String getToday() {     //lấy ngày hiện tại và thời gian hiện tại
    DateTime now = DateTime.now();
    String formattedToday = DateFormat('dd-MM-yyyy hh:mm').format(now);
    return formattedToday;
  }

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), 
        title:const Text("Thông tin đơn hàng", style: TextStyle(fontSize: 25, color: Colors.black),),
        backgroundColor: Colors.pink[50],
        actions: [
          IconButton(onPressed:(){}, 
          icon: Icon(Icons.question_mark_outlined,color: Colors.red, size: 30))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130,
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 49, 202, 189),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[ 
                  Expanded(
                   child: Center(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          const Text(" Người bán đang chuẩn bị đơn hàng", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                          RichText(text: TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            children: [
                              const TextSpan(
                                text: "Đơn hàng sẽ được chuẩn bị và chuyển đi trước ",
                              ),
                              TextSpan(
                                text: getNextday(1),
                                style:const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                       ],
                     ),
                    )
                  ),
                  Container(
                  width:MediaQuery.sizeOf(context).width /4-20, 
                  child:const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_shipping,
                        size: 70,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                ],
              ),     
            ),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                color: Colors.white
              ),
              child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_shipping_outlined,size: 30,color: Colors.grey,),
                    SizedBox(width: 10,),
                    Text("Thông tin vận chuyển",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 42),
                      Text("Nhanh",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 116, 113, 113)))
                  ],
                )
              ],
            ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                 color: Colors.white
              ),
              child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 30,color: Colors.grey),
                      SizedBox(width: 10,),
                      Text("Địa chỉ nhận hàng",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Row(
                  children: [
                    SizedBox(width: 42),
                    Text(widget.orderdetailinfo.name,
                    style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 116, 113, 113)))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 42),
                      Text(widget.orderdetailinfo.phone,
                      style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 116, 113, 113)))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 42),
                      Expanded(
                        child: Text(widget.orderdetailinfo.address,
                        style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 116, 113, 113)),
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ),
                    ],
                  ),
                ]
              ), 
            ),
            SizedBox(height: 10,),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shopify_rounded,size: 30,color: Colors.red),
                      SizedBox(width: 10,),
                      Text("Phương thức thanh toán",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 42),
                        Text(widget.orderdetailinfo.typePayment,style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 116, 113, 113)))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Column(
            children: widget.orderdetailinfo.products.map((product) {
              return Container(
                height: 130,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10), // Để tạo khoảng cách giữa các sản phẩm
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      margin: EdgeInsets.only(right: 15),
                      child: Image.network(
                        product.image,
                        width: 100,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(product.productName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('Số lượng: ', style: TextStyle(fontSize: 16),),
                                  Text(product.quantity.toString(), style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              Row(
                                children:[
                                  (product.promotion == 0)? 
                                  Text('đ${intToString(product.price)}', style: TextStyle(fontSize: 16)):
                                  Text('đ${intToString(product.promotion)}', style: TextStyle(fontSize: 16)),
                                ],
                              )
                                                          ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            ),
                Container(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(10, 15, 10,0),
                      decoration: BoxDecoration(
                      color: Colors.white
                      ),
                      child: Column(
                        children: [ 
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tổng tiền hàng", style: TextStyle(fontSize: 16,color: Colors.grey)),
                              Text('đ'+widget.orderdetailinfo.productmoney,
                                style: TextStyle(fontSize: 16,color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text("Phí vận chuyển",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                Text('đ'+widget.orderdetailinfo.deliverycharges,style: TextStyle(fontSize: 16,color: Colors.grey),),
                              ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text("Thành tiền",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text('đ'+widget.orderdetailinfo.totalPayment,style: TextStyle(fontSize:16, color: Colors.red),),
                              ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text("Mã đơn hàng",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text(widget.orderdetailinfo.OrderId,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text("Thời gian đặt hàng",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                Text(getToday(),style: TextStyle(fontSize: 16,color: Colors.grey),),
                              ],
                          ),
                        ]
                    ),
                 ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowAlertDialog(orderId: widget.orderdetailinfo.OrderId,userId: widget.Id,);
                          },
                        );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[400],
                          side: const BorderSide(color: Colors.black),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child:const Text("Hủy mua hàng",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                 ),
                 SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationScreen(userId: widget.Id,)),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[300],
                          side: const BorderSide(color: Colors.black),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child:const Text("Quay về Trang chủ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                 ),
             ]
          ),  
      ),
    );
  }
}
class ShowAlertDialog extends  StatelessWidget {
  const ShowAlertDialog({Key? key,required this.orderId, required this.userId}) : super(key: key);
  final String orderId;
  final String userId;
  @override
  Widget build(BuildContext context) {
  DatabaseReference paymentRef = FirebaseDatabase.instance.ref().child('orders');

  void updateStatus() {
    String newStatus = 'Đã Hủy';
    paymentRef.child(orderId).update({'status': newStatus,
    }).then((_) {
      print('Cập nhật trạng thái thành công');
    }).catchError((error) {
      print('Lỗi khi cập nhật trạng thái: $error');
    });
 }
    return AlertDialog(
      title:Row(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child:Row(
                children: [
                  Icon(Icons.notification_important_outlined,color: Colors.black,),
                  Text("Thông báo"),
                ],
              )
            ),
          ],
        ),
      content: Text("Bạn có muốn hủy đơn hàng này không?"),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Không'),
        ),
       
        TextButton(
          onPressed: () async {
             await initNotifications();
             updateStatus();
             showNotificationOderDelete(orderId);
             saveNotification(userId, orderId);
             Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen(userId: userId,)),
              (route) => false,
            );
          },
          child: Text('Đồng ý'),
        ),
        ],)
      ],
    );
  }
}
void saveNotification(String userId, String orderId)
{
NotificationData notificationData = NotificationData(
    AdminId: userId,
    userId: "",
    title: "Đơn hàng đã bị hủy",
    description: "Bạn đã hủy đơn hàng ${orderId} thành công.",
    time: DateTime.now(),
  );
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  _databaseReference.child('notifications').push().set({
    'AdminId': notificationData.AdminId,
    'userId': notificationData.userId,
    'title': notificationData.title,
    'description': notificationData.description,
    'time': notificationData.time.millisecondsSinceEpoch,
  }).then((value) {
    print("Data saved successfully!");
  }).catchError((error) {
    print("Failed to save data: $error");
  });
}