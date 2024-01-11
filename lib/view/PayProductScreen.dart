
import 'package:doandidongappthuongmai/models/orderdetail.dart';
import 'package:doandidongappthuongmai/view/OrderDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class PaymentScreen extends StatefulWidget {
 
  final String image;
  final String productName;
  final String price;
  final int Quantity;
  const PaymentScreen({Key? key,required this.image,required this.productName,required this.price,required this.Quantity}) : super(key: key);
  
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}
  int stringToInt(String Value) {   // chuyển kiểu chuổi về kiểu int
    String cleanedString = Value.replaceAll('.', '');  //xóa các dấu . , trong chuỗi
    return int.parse(cleanedString);
  }

  String intToString(int number) {   // chuyển kiểu int về lại chuổi theo định dạng tiền việt nam
    NumberFormat format = NumberFormat('#,###', 'vi_VN');
    return format.format(number);
  }

  String getNextday(int numberdays) {  //lấy ngày tíêp theo
    DateTime now = DateTime.now();   //lấy ngày ht
    DateTime nextday = now.add(Duration(days: numberdays));  //  ht + số ngày nhập --> ngày típ theo
    String formatNextday = DateFormat('dd-MM').format(nextday);  // định dạng ngày và tháng 
    return formatNextday; 
  }

  String totalPayment(String price, int Quantity, String phigiaohang) {    // tính tiền tổng hóa đơn
    int priceAsInt = stringToInt(price);
    int total = (priceAsInt * Quantity) + stringToInt(phigiaohang);
    return intToString(total);
  }


String ProductMoney( String price, int Quantity)  // tính tiền sản phẩm 
{
   int priceAsInt = stringToInt(price);
   int money = (priceAsInt * Quantity);
   return intToString(money);
}

// tạo thông tin mặc định
String typePayment ="Tiền mặt khi nhận hàng";
const String phigiaohang="15.000";
const String name ="HuynhThanhDuy";
const String phone ="0192888888";
const String address= "45/6 Trần đình xu, Cô giang , Q1 ,Tp. Hồ Chí Minh";

class _PaymentScreenState extends State<PaymentScreen> {
   int selectedPaymentOption = 1;
  @override
  Widget build(BuildContext context) {
    String totalpayment = totalPayment(widget.price, widget.Quantity, phigiaohang); // gán giá trị 
    String productmoney= ProductMoney(widget.price, widget.Quantity);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: const Text("Thanh toán",style: TextStyle(color: Colors.black, fontSize: 25),),
        iconTheme: const IconThemeData(color: Colors.black), 
      ),
      body:  SingleChildScrollView(
        child:Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                child: Row(
                  children: [
                  Icon(Icons.location_on, color: Colors.red,size: 30,),
                  Text("Địa chỉ nhận hàng", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          Column(
            children: [
            Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(35, 5, 0, 0),
               decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.2),
              ),
              child:const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Row(children: [Text(name,style: TextStyle(fontSize: 17)),],),
                SizedBox(height: 13,),
                Row(children: [Text(phone,style: TextStyle(fontSize: 17),),],),
                SizedBox(height: 13,),
                Expanded(
                  child: Text(address,
                      style: TextStyle(fontSize: 17),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ),
                  ],
                ),
              
              ),
            ],
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              Container(
                height: 130,
                padding: EdgeInsets.all(10),
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
                      child: Image.asset(widget.image, 
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
                          Text(widget.productName,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Row(
                              children: [
                                Text('Số lượng: ',style: TextStyle(fontSize: 16),),
                                Text(widget.Quantity.toString(),style: TextStyle(fontSize: 16),),
                                ],
                            ),
                            Column(
                              children: [
                                Text('đ'+ widget.price ,style: TextStyle(fontSize: 16),),
                                ],
                            ),
                              ],
                            ),
                          ],
                          ),
                      ),
              
                   ],
                  ),
                ),
              ],
          ),
          SizedBox(height: 1,),
          Column(
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width:1.0,),
                ),
                child: Row(
                  children: [
                    Expanded(child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Hình thức vận chuyển",style: TextStyle(fontSize: 20),),
                        
                         Text("Nhanh",style: TextStyle(fontSize: 18)),
                         Text("Nhận hàng vào ${getNextday(2)} - ${getNextday(5)}", style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),)
                        ],
                      )
                     ),
                      Container(
                      width:MediaQuery.sizeOf(context).width /5-15, 
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("đ${phigiaohang}",style: TextStyle(fontSize: 17, color: Colors.black),)
                         ],
                       ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(height: 1),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width:1.0,),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chọn hình thức thanh toán",style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    RadioButton(1, Icons.money, "Tiền mặt khi nhận hàng"),
                    RadioButton(2, Icons.wallet, "Ví Momo"),
                    RadioButton(3, Icons.home_work_outlined, "Chuyển khoản"),
                  ],
                  ),
                )
              ],
            ),
            SizedBox(height: 1,),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const  Text("THÔNG TIN HÓA ĐƠN",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tiền hàng", style: TextStyle(fontSize: 20)),
                          Text(productmoney+'đ',style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text("Phí giao hàng",style: TextStyle(fontSize: 20),),
                            Text(phigiaohang+'đ',style: TextStyle(fontSize: 20),),
                          ],
                      ),
                      SizedBox(height: 10),      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text("Tổng đơn hàng",style: TextStyle(fontSize: 20),),
                            Text(totalpayment+'đ',style: TextStyle(fontSize: 20),),
                          ],
                      ),
                    ],
                  ),
                ),
              ],
           ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      OrderDetails orderDetailsInfo = OrderDetails(
                          image: widget.image,
                          productName: widget.productName,
                          price: widget.price,
                          Quantity: widget.Quantity,
                          name: name,
                          phone: phone,
                          address: address,
                          typePayment: typePayment,
                          productmoney: productmoney,
                          deliverycharges: phigiaohang,
                          totalPayment: totalpayment,
                        );
                       Navigator.push(context,MaterialPageRoute(builder: (context) => OrderDetailScreen(orderdetailinfo: orderDetailsInfo,) ),);
                    },                           //chuyển đến chi tiết hóa đơn
                     
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, 
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:const LinearGradient(
                          colors: [Color.fromARGB(255, 237, 161, 227), Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),   // Màu của đổ bóng
                            spreadRadius: 2,   // Bán kính đổ bóng
                            blurRadius: 10,    // Độ mờ của đổ bóng
                            offset: Offset(0, 7),   // Vị trí đổ bóng
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      child: const Center(
                        child: Text("ĐẶT HÀNG NGAY",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, 
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
            ],
          ),
        ),      
    );
  }
  Widget RadioButton(int value, IconData icon, String text) {      // Tạo đối tượng Radio Button và xử lý sự kiện khi người dùng chọn
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedPaymentOption = value;   //lấy giá trị khi có radio đó dc chọn
        typePayment=text;
      });
    },
    child: Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedPaymentOption == value ? Color.fromARGB(255, 145, 218, 128) : Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
              color: selectedPaymentOption == value ? Color.fromARGB(255, 145, 218, 128) : Colors.transparent,
              border: Border.all(
              color: selectedPaymentOption == value ? Color.fromARGB(255, 145, 218, 128) : Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        SizedBox(width: 10),
        Icon(icon,
          size: 30,
          color: selectedPaymentOption == value ? Colors.green : Colors.grey,
        ),
          SizedBox(width: 10),
          Text(text,
            style: TextStyle(
              fontSize: 18,
              color: selectedPaymentOption == value ? Colors.green : Colors.grey,
            ),
          ),
        ],
      )
    ),
  );
 }
 
}

 