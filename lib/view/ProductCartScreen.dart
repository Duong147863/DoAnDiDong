import 'package:doandidongappthuongmai/view/ItemProductCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductCartScreen extends StatefulWidget {
  const ProductCartScreen({super.key});

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Color.fromARGB(255, 12, 2, 46)),),
        title: const Text("Giỏ hàng",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 12, 2, 46)),),
        backgroundColor:Colors.pink[50],
       ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
        children: [
         Container(
            height: 130,
            width: MediaQuery.of(context).size.width-30 ,

            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 240, 240),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ItemProductCart(),
        )
      ],
      )
    ],
    ),
    ),    
    ],),
    bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Tổng tiền: ",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 2, 46)),
                  ),
                  Text("99.000.000",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 2, 46)),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: ElevatedButton(onPressed: (){},
                child: Text('Mua hàng',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 12, 2, 46)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20,horizontal: 40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
              )
            ),
              ),
              )
            ],
          ),
        ),
    );
  }
}