import 'package:doandidongappthuongmai/components/GetCart.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:doandidongappthuongmai/view/ProductCartScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String Id;
  final String idproduct;
  final String image;
  final String productName;
  final int price;
  final int promotion;
  final String description;
  final int quantity;
  final String producer;

  const ProductDetailsScreen({
    Key? key,
    required this.Id,
    required this.idproduct,
    required this.image,
    required this.productName,
    required this.price,
    required this.promotion,
    required this.producer,
    required this.quantity,
    required this.description,
  }) : super(key: key);
  

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
  
}

int getPromotionOrPrice(int Price, int promotion) {
  return (promotion > 0) ? promotion : Price;
}

Future<int> getCartItemCount() async {
  DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('carts');
  DatabaseEvent event = await cartRef.once();
  DataSnapshot snapshot = event.snapshot;

  if (snapshot.value is Map) {
    int itemCount = (snapshot.value as Map).length;
    return itemCount;
  } else {
    return 0; // Hoặc giá trị mặc định nếu không phải là Map
  }
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int totalCartQuantity =0;
  int countquantity = 1;

  @override
  void initState() {
    super.initState();
    loadCartQuantity();
  }
  void loadCartQuantity() async {
    int quantity = await getCartItemCount();
    setState(() {
      totalCartQuantity = quantity;
     
    });
  }
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  loadCartQuantity();
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          Navigator.pop(context,true);
          return true;
      },child:Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
        title: Text('Chi tiết sản phẩm', style: TextStyle(color: Colors.black)),
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
                          builder: (context) => ShoppingCartScreen(Id: widget.Id,),
                        ),
                      ).then((value) {
                        if (value != null && value) {
                          setState(() {
                            loadCartQuantity();
                            Provider.of<CartProvider>(context, listen: false).loadCartQuantity(); 
                         });
                        }
                      });
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
                    child: Text(
                      '${totalCartQuantity.toString()}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image, height: 220, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(
            widget.productName,
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            softWrap: true,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              if (widget.promotion > 0)
                Row(
                  children: [
                    Text('${widget.promotion}đ', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                    Text(
                      '${widget.price}đ',
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
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (totalCartQuantity >= 10) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thông báo'),
                            content: Text('Giỏ hàng đã đầy, không thể thêm sản phẩm mới.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Cart carts = Cart(
                        promotion: widget.promotion,
                        image: widget.image,
                        CartId: widget.idproduct,
                        productName: widget.productName,
                        price: widget.price,
                        isSelected:false,
                        quantity: 1,
                      );
                      saveProductToFirebase(carts, widget.idproduct);
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
                  label: const Text("Thêm giỏ hàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[200],
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showBottomSheet(context, widget.image, widget.price, widget.productName, widget.promotion, widget.idproduct, widget.Id);
                  },
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  label: const Text("Mua ngay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, String image, int price, String productName, int promotion, String idproduct, String userId) {
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
                                Text('${promotion}đ', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                                Text( '${price}đ',
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
                      Text("Số lượng", style: TextStyle(fontSize: 17),),
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
                            Text('$countquantity', style: TextStyle(fontSize: 17),),
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
                            int Price = getPromotionOrPrice(price, promotion);
                            List<Cart> selectedProducts = [
                              Cart(
                                CartId:idproduct,
                                productName: productName,
                                image: image,
                                price: Price,
                                quantity: countquantity,
                                promotion: promotion,
                                isSelected: true
                              ),
                              // Add more Cart objects if needed
                            ];

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  selectedProducts: selectedProducts,
                                  Id: widget.Id,
                                ),
                              ),
                            ).then((value) {
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            side: const BorderSide(color: Colors.black),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text("Mua ngay",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
  void saveProductToFirebase(Cart cart, String cartId) {
    DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('carts');
    var newCartRef = cartRef.child(cartId);

    newCartRef.once().then((DatabaseEvent event) async {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? snapshotValue = snapshot.value as Map<dynamic, dynamic>?;
      if (snapshot.value == null) {
        newCartRef.set({
          'cartId': cart.CartId,
          'productname': cart.productName,
          'image': cart.image,
          'price': cart.price,
          'quantity': cart.quantity,
          'promotion':cart.promotion
        });
        setState(() {totalCartQuantity += 1; });
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        cartProvider.updateCartQuantity(totalCartQuantity);
      } else {
        int currentQuantity = snapshotValue?['quantity'] ?? 1;
        newCartRef.update({'quantity': currentQuantity + 1});
      }
    }).catchError((error) {
      print('Error adding product to Firebase: $error');
    });
  }
}
