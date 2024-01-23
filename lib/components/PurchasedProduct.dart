import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:flutter/material.dart';
import '../view/ProductDetailScreen.dart';

class PurchasedProduct extends StatefulWidget {
  const PurchasedProduct({Key? key}) : super(key: key);

  @override
  State<PurchasedProduct> createState() => _PurchasedProductState();
}

class _PurchasedProductState extends State<PurchasedProduct> {
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Product.fetchProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // hiện khi đang load dữ liệu
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: const Text("Dang tải dữ liệu....."),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = products[index];
              Map<String, dynamic> data = {
                'name': product.name,
                'price': product.price,
                'quantity': product.quantity,
                'image': product.image,
                'promotion': product.promotion,
              };
              return Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (data['promotion'] != 0)
                                      Stack(
                                        children: [
                                          Text(
                                            '${data['price']} đ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.black,
                                              decorationThickness: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (data['promotion'] == 0)
                                      Stack(
                                        children: [
                                          Text(
                                            '${data['price']} đ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (data['promotion'] != 0)
                                      Stack(
                                        children: [
                                          Text(
                                            '${data['promotion']} đ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (data['promotion'] == 0)
                                      Container(
                                        height: 20,
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 8,
                      right: 12,
                      child: SizedBox(
                        width: 100,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nhấn
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                          Id: product.id,
                                          idproduct: product.idproduct,
                                          image: product.image,
                                          productName: product.name,
                                          price: product.price,
                                          promotion: product.promotion,
                                          producer: product.producer,
                                          description: product.description,
                                          quantity: product.quantity,
                                        )));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                                side: const BorderSide(
                                    color: Colors.black, width: 1.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Mua lại',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
