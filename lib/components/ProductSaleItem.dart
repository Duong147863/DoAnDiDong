import 'package:doandidongappthuongmai/view/ProductDetailScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';

class ProductSaleItem extends StatefulWidget {
  ProductSaleItem({Key? key, required this.ProductsaleReference, required this.id}) : super(key: key);

  final DatabaseReference ProductsaleReference;
  final String id;

  @override
  State<ProductSaleItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductSaleItem> {
  DatabaseReference productsale = FirebaseDatabase.instance.ref().child('productsales');
  ProductSale products = ProductSale(id: "0", category: "", name: "", description: "", idproduct: "", image: "", producer: "", price: 0, promotion: 0, quantity: 0);

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
              Id: widget.id,
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
                if ((products.promotion == 0) && (products.price >0))
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
    try {
      DatabaseEvent event = await widget.ProductsaleReference.once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        if (dataSnapshot.value is Map) {
          Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
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
