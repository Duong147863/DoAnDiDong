import 'package:doandidongappthuongmai/view/ProductDetailScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';

class ProductSellItem extends StatefulWidget {
  const ProductSellItem({Key? key, required this.ProductsellReference , required this.id}) : super(key: key);

  final DatabaseReference ProductsellReference;
  final String id;
  @override
  State<ProductSellItem> createState() => _ProductItemState();
}
final  String defaultimage="https://firebasestorage.googleapis.com/v0/b/doandidong-a3982.appspot.com/o/image%2FnoImage.jpg?alt=media&token=c8152bb5-3f3b-4dac-ace4-a64b231f15e4";
class _ProductItemState extends State<ProductSellItem> {
  DatabaseReference productsell = FirebaseDatabase.instance.ref().child('productsells');
  Product products = Product(id: "0", category: "", name: "", description: "", idproduct: "", image: defaultimage, producer: "", price: 0, promotion: 0, quantity: 0, sell: false, suggest: false);
  
  @override

  Widget build(BuildContext context) {
    if (products.id == "0") {
      return CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              Id:  widget.id,
              idproduct: products.idproduct,
              image: products.image,
              productName: products.name,
              price: products.price,
              producer: products.producer,
              promotion: products.promotion,
              description: products.description,
              quantity: products.quantity,
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54, width: 1),
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
                  image:NetworkImage('${products.image}'),
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
                if (products.promotion > 0)
                  Column(
                    children: [
                      Text('${products.promotion}đ', style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
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
                if ((products.promotion == 0) && (products.price > 0))
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
    loadDataFromFirebase();
  }

  void loadDataFromFirebase() async {
    try {
      DatabaseEvent event = await widget.ProductsellReference.once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        if (dataSnapshot.value is Map) {
          Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
          String productsId = data["idproduct"]?.toString() ?? "";

          setState(() {
            products = Product.fromJson(productsId, data);
          });
        } else {}
      }
    } catch (e) {
      print("Error loading data: $e");
    }
  }
}
