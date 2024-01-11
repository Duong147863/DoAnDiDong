import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Color.fromARGB(255, 12, 2, 46)),),
        title: const Text("Chi tiết sản phẩm",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
        backgroundColor:Colors.pink[50],
       ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFD4ECF7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )
            ),
            child: Stack(
              children: [
                Center(child: Image.asset("assets/img/boc_rac.jpg")),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding:const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bọc rác Louis Vuitton",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Row(
                children: [
                Text("99.000.000 VNĐ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),
                SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                      onPressed: (){
                          setState(() {
                            quantity--;
                            if (quantity < 1) {
                                quantity = 1;
                              }
                        });
                      }, icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal:10),
                      child:  Text('$quantity',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(onPressed: (){
                          setState(() {
                            quantity++;
                        });
                      }, icon: const Icon(Icons.arrow_forward_ios_outlined,color: Color.fromARGB(255, 12, 2, 46),size: 15,),),
                    )
                  ],
                )
                ],
                ),
                const SizedBox(height: 10),
                const Text("Thông tin sản phẩm: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46))),
              ],
            ),
          ),
        ],  
      )),
      bottomNavigationBar: Padding(
      padding: EdgeInsets.all(5),
      child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    
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
}