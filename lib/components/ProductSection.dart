import 'package:doandidongappthuongmai/components/ProductSellItem.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SectionList extends StatefulWidget {
  final List<CategoryData> categories;
  final String id;
  const SectionList({Key? key, required this.categories, required this.id}) : super(key: key);

  @override
  _SectionListState createState() => _SectionListState();
}

class CategoryData {
  final String id;
  final String name;

  CategoryData({required this.id, required this.name});
}

class _SectionListState extends State<SectionList> {
  int selectedButtonIndex = 0;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProductsell();
  }

  void _loadProductsell() async {
   
    List<Product> productsell = await Product.fecthProductSell(widget.categories[selectedButtonIndex].id);
    setState(() {
      products = productsell;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Container(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = index;
                      _loadProductsell(); // Call _loadProductsell when a button is pressed
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == index ? Colors.blue[200] : Colors.grey[100],
                    side: BorderSide(color: Colors.black),
                  ),
                  child: Text(
                    widget.categories[index].name,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              var productsell = products[index];
              return ProductSellItem(
                key: ValueKey<String>(productsell.id),
                ProductsellReference: FirebaseDatabase.instance.ref().child('products').child(productsell.id.toString()),
                id: widget.id,
              );
            },
          ),
        ),
        SizedBox(height: 10),
        // Text(
        //   "Xem thêm sản phẩm bán chạy",
        //   style: TextStyle(decoration: TextDecoration.underline, color: Colors.green),
        // ),
      ],
    );
  }
}
