import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}
String getTomorrow(int numberdays) {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(Duration(days: numberdays)); 

  String formattedTomorrow = DateFormat('dd-MM-yyyy').format(tomorrow);

  return formattedTomorrow;
}
class _OrderDetailScreenState extends State<OrderDetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                text: getTomorrow(1),
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
          ],
        ),
      ),
      
    );
  }
}