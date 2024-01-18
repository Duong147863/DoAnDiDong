import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:doandidongappthuongmai/view/ProductCartScreen.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String image;
  final String productName;
  final int price;
  final int promotion;
  final String description;
  final int quantity;
  final String producer;
  
  const ProductDetailsScreen({
    Key? key,
    required this.image,
    required this.productName,
    required this.price,
    required this.promotion,
    required this.producer,
    required this.quantity,
    required this.description
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int totalCartQuantity = 0;  //số lượng trong giỏ hàng
  int countquantity = 1;  //số lượng sản phẩm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.pink[50],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 35, right: 15),
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.red, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              if (totalCartQuantity > 0)
                Positioned(
                  right: 10,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('${totalCartQuantity.toString()}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body:ListView(
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image, height: 220, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          Padding(
            padding:const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),softWrap: true),
                SizedBox(height: 10),
                Text('${widget.promotion.toString()}đ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),
                SizedBox(height: 10),
                Row(
                  children: [
                      if (widget.promotion > 0)
                        Row(
                          children: [
                            Text('${widget.promotion}đ',style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                            SizedBox(width: 10,),
                            Text( '${widget.price}đ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                            ),
                          ],
                        ),
                      if ((widget.promotion == 0) && widget.price > 0)
                      Text( '${widget.price}đ',
                        style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Thông tin sản phẩm: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46))),
                const SizedBox(height: 5),
                Text(widget.description,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Color.fromARGB(255, 12, 2, 46)),softWrap: true,),
                const SizedBox(height: 8),
                Text('Nhà sản xuất: ${ widget.producer}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),softWrap: true,),
              ],
            ),
          ),
        ],  
        )
        ],
      ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(5),
          child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          totalCartQuantity = totalCartQuantity + 1;
                        });
                      },
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
                      label: const Text("Thêm giỏ hàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showBottomSheet(context, widget.image, widget.price,widget.productName, widget.promotion);   // hiện bottomSheet 
                      },
                      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
                      label: const Text("Mua ngay", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[300],
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
  
_showBottomSheet(BuildContext context, String image, int price, String productName, int promotion,) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(image, height: 150, width: 150),
                      SizedBox(width: 10,),
                          Row(
                           children: [
                              if (promotion > 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${promotion}đ',style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                                    Text('${price}đ',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                    ),
                                  ],
                                ),
                              if ((promotion == 0) && price > 0)
                              Text( '${price}đ',
                                style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                        ],
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Số lượng",style: TextStyle(fontSize: 17),),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  countquantity--;
                                  if (countquantity < 1) {
                                    countquantity = 1;
                                  }
                                });
                              },
                            ),
                            Text('$countquantity',style: TextStyle(fontSize: 17),),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  countquantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context) => PaymentScreen( image: image,price: price, productName: productName, CountQuantity: countquantity,),),
                          ).then((value) {
                            // Đóng BottomSheet khi quay lại từ trang thanh toán
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[300],
                          side: const BorderSide(color: Colors.black),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child:const Text("Mua ngay",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                 ),
               
                ],
              ),
            );
          },
        );
      },
    );
  }
}
