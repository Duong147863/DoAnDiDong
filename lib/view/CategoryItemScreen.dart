import 'package:doandidongappthuongmai/components/ProductSuggestItem.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.name, required this.CategoryId, required this.id});
  final String CategoryId;
  final String name;
  final String id;

   @override
  _CategoryItemState createState() => _CategoryItemState();
  
}

class _CategoryItemState extends State<CategoryItem> {
  String? selectedValue;
  List<Product> _product= [];
  final List<String> Items = [
    'Giá giảm dần',
    'Giá tăng dần',
  ];
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }
  void _loadProducts() async {
    List<Product> productsByCategory = await Category.getProductsByCategory(widget.CategoryId);
    setState(() {
      _product = productsByCategory;
    });
  }
 void sortProductsByPrice(String select) {
  if (select == 'Giá tăng dần') {
   _product.sort((a, b) {
      num priceA = (a.promotion != 0 ? a.promotion : a.price);
      num priceB = (b.promotion != 0 ? b.promotion : b.price);
      return priceA.compareTo(priceB);
    });
  } else if (select == 'Giá giảm dần') {
   _product.sort((a, b) {
      num priceA = (a.promotion != 0 ? a.promotion : a.price);
      num priceB = (b.promotion != 0 ? b.promotion : b.price);
      return priceB.compareTo(priceA);
    });
  }
  setState(() {});
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        iconTheme: IconThemeData(color: Colors.black),
        title:Column(
          children: [
              Text(widget.name, style: TextStyle(color: Colors.black, fontSize: 22),),
          ],
        ),  
      ),
      body:SingleChildScrollView(
        child: Column(
         children:[
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1,color: Colors.black),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  const Row(
                      children: [
                        Icon(Icons.filter_list_alt),
                        Text("Bộ lọc",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                Container(
                  height: 70,
                  width: 150,
                  child: Row(
                    children:[
                       Expanded(child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        hint: const Text('Sắp xếp theo',style: TextStyle(fontSize: 14),),
                        items: Items.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,style: const TextStyle(fontSize: 14,), ),)).toList(),
                          validator: (value) {
                            if (value == null) { return 'Sắp xếp theo';}
                               return null;
                            },
                            onChanged: (value) {
                                setState(() {
                                 selectedValue = value;
                                 sortProductsByPrice(selectedValue.toString());
                                });
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.black45,),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ], 
              ),
            ),
           Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height:MediaQuery.of(context).size.height*0.8,
                child: ListView.builder(
                  itemCount: (_product.length/2).ceil(),  // làm tròn 
                  itemBuilder: (context, index) {
                    if(_product.length %2 !=0 && index == (_product.length/2).ceil()-1)
                    {
                      return Row(
                        children:[
                          ProductSuggestItem(key: ValueKey<String>(_product[index*2].id),
                            ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(_product[index*2].id.toString()) ,
                            id: widget.id,
                            ),
                        ]
                      );
                    }
                    else{
                    return Row(
                      children: [
                       ProductSuggestItem(key: ValueKey<String>(_product[index*2].id),
                          ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(_product[index*2].id.toString()) ,
                          id: widget.id,
                          ),
                        ProductSuggestItem(key: ValueKey<String>(_product[index*2+1].id),
                          ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(_product[index*2+1].id.toString()) ,
                          id: widget.id,
                          ),
                      ],
                     );
                    }
                  },
                ),
              ),
            ],
          )
        ],
        ),
      )
    );
  }
}
