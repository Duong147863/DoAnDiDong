import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title:  Center(child: Text("Thông báo",style: TextStyle(color: Colors.black, fontSize: 25),)),
        iconTheme: const IconThemeData(color: Colors.black), 
        
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(10),
            child: Text("Cập nhật thông báo"),
            decoration: BoxDecoration(color: Colors.grey[350]),
            
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image.asset("assets/img/tmdt1.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment
                          .start,
                    children: [
                      Text("Đơn hàng giao thành công", style: TextStyle(fontSize: 20), softWrap: true,),
                      Text("Đơn hàng 2312120E2NqMq2 của bạn vẫn đang trong quá trình vận chuyện thành công")
                    ],
                  )
                )
              ],
            ),
          ),Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image.asset("assets/img/tmdt1.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment
                          .start, // Đặt crossAxisAlignment thành start
                    children: [
                      Text("Đơn hàng giao thành công", style: TextStyle(fontSize: 20), softWrap: true,),
                      Text("Đơn hàng 2312120E2NqMq2 của bạn vẫn đang trong quá trình vận chuyện thành công")
                    ],
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image.asset("assets/img/tmdt1.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment
                          .start, // Đặt crossAxisAlignment thành start
                    children: [
                      Text("Đơn hàng giao thành công", style: TextStyle(fontSize: 20), softWrap: true,),
                      Text("Đơn hàng 2312120E2NqMq2 của bạn vẫn đang trong quá trình vận chuyện thành công")
                    ],
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image.asset("assets/img/tmdt1.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment
                          .start, // Đặt crossAxisAlignment thành start
                    children: [
                      Text("Đơn hàng giao thành công", style: TextStyle(fontSize: 20), softWrap: true,),
                      Text("Đơn hàng 2312120E2NqMq2 của bạn vẫn đang trong quá trình vận chuyện thành công")
                    ],
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Image.asset("assets/img/tmdt1.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment
                          .start, // Đặt crossAxisAlignment thành start
                    children: [
                      Text("Đơn hàng giao thành công", style: TextStyle(fontSize: 20), softWrap: true,),
                      Text("Đơn hàng 2312120E2NqMq2 của bạn vẫn đang trong quá trình vận chuyện thành công")
                    ],
                  )
                )
              ],
            ),
          ),
        ],
      
      ),
    );
  }
}