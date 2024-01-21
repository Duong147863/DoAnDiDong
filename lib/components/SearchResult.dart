import 'package:doandidongappthuongmai/components/ProductResultItem.dart';
import 'package:flutter/material.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';

class SearchResult extends StatefulWidget {
  SearchResult({super.key, required this.searchText, required this.id});
  final String searchText;
  final String id;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Product> allProducts = [];
  List<Product> searchResults = [];
  
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
  List<Product> products = await Product.fetchProducts();
  setState(() {
    allProducts = products;
    searchResults = filterProducts(widget.searchText);
  });
}
  List<Product> filterProducts(String searchText) {
    List<Product> filteredProducts = [];
    String searchTermNormalized = TiengViet.parse(searchText);

    for (Product product in allProducts) {
      String productNameNormalized = TiengViet.parse(product.name);
      if (productNameNormalized.toLowerCase().contains(searchTermNormalized.toLowerCase())) {
        filteredProducts.add(product);
      }
    }
    // print("Filtered products: $filteredProducts");
    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm cho "${widget.searchText}"', style: TextStyle(color: Colors.black, fontSize: 18),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.pink[50],
      ),
      body: searchResults.isEmpty? 
          Center(
              child: Text('Không tìm thấy kết quả', style: TextStyle(color: Colors.black, fontSize: 18),),
            ): SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Tìm thấy ${searchResults.length} kết quả phù hợp", style: TextStyle(color: Colors.black, fontSize: 18),)
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      itemCount: (searchResults.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        if (searchResults.length % 2 != 0 && index == (searchResults.length / 2).ceil() - 1) {
                          return Row(
                            children: [
                              ProductResultItem(key: ValueKey<String>(searchResults[index*2].id),
                                ProductReference:FirebaseDatabase.instance.ref().child('products').child(searchResults[index*2].id.toString()) ,
                                id: widget.id,
                                ),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              ProductResultItem(key: ValueKey<String>(searchResults[index*2].id),
                                ProductReference:FirebaseDatabase.instance.ref().child('products').child(searchResults[index*2].id.toString()) ,
                                id: widget.id,
                                ),
                              ProductResultItem(key: ValueKey<String>(searchResults[index*2+1].id),
                                ProductReference:FirebaseDatabase.instance.ref().child('products').child(searchResults[index*2+1].id.toString()) ,
                                id: widget.id,
                                ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
