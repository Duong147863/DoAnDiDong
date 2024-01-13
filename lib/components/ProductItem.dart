import 'package:doandidongappthuongmai/view/ProductDeatailScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';

class ProductItem extends StatefulWidget {
  ProductItem({Key? key,required this.ProductsaleReference}) : super(key: key);

  final DatabaseReference ProductsaleReference;
  @override
  State<ProductItem> createState() => _ProductItemState();
} 
class _ProductItemState extends State<ProductItem> {
  DatabaseReference productsale = FirebaseDatabase.instance.ref().child('productsales');
  ProductSale products= ProductSale(id: "0",category: "",name: "", description: "", idproduct: "",image: "", producer: "", price: 0,promotion: 0, quantity: 0);
  @override
  Widget build(BuildContext context) {
     if (products.id==0) {
      return CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: () {          //chuyển đến chi tiết sản phẩm
       Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetailsScreen(   
            image: products.image,
            productName: products.name,
            price: products.price.toString(),
          ), 
        ),
      );
      },
      child:Container(
      width: 110,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54, width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 108,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(products.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            products.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5,),
          
          Row(
            children: [
              if (products.promotion > 0) //có giảm giá
                Column(
                  children: [
                  
                    Text('${products.promotion}đ',style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),             
                    Text(
                      '${products.price}đ',
                      style: const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              
              if(( products.promotion == 0) && products.price != null)  //không có giảm giá
                Text(
                  '${products.price}đ',
                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ],
      ),
     ),
    );
  }
  @override
  void initState() {
    super.initState();
    loadDataFromFirebase1();
  }
  void loadDataFromFirebase1() async {
  // print("Load data from Firebase - roomID: ${widget.ProductsaleReference.key}");
  try {
    DatabaseEvent event = await widget.ProductsaleReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      if (dataSnapshot.value is Map) {
        Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
        // print("Data from Firebase: $data");
        String productsId = data["idproduct"]?.toString() ?? "";

        setState(() {
         products = ProductSale.fromJson(productsId, data);
        });
      } else {}
    }
    } catch (e) {
      print("Error loading data: $e");
    }
 }
}

 

