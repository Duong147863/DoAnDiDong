import 'package:doandidongappthuongmai/components/CartItem.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:flutter/material.dart';
class ShoppingCartScreen extends StatefulWidget {
  final String Id;
  const ShoppingCartScreen({Key? key, required this.Id});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
 List<Cart> allCartItem = [];
  Set<String> selectedCart = {}; 
  int totalAmount = 0;    //lấy tổng tiền các sản phẩm được chọn

  Future<void> _loadCartItem() async {
  List<Cart> carts = await Cart.fetchCart(widget.Id);
  setState(() {
    allCartItem = carts;
    calculateTotalAmount();   
  });
  }

  void calculateTotalAmount() {     //hàm tính tổng tiền
  setState(() {
    totalAmount = 0;
    for (var cartItem in allCartItem) {
      if (selectedCart.contains(cartItem.CartId)) 
      {
        if (cartItem.price > 0 && cartItem.promotion == 0) {    //nếu ko có giá giảm thì lấy giá gốc
          totalAmount += cartItem.quantity * cartItem.price;
        } else if (cartItem.promotion > 0) {     //nếu có giá giảm thì lấy giá giảm
          totalAmount += cartItem.quantity * cartItem.promotion;
        }
      }
    }
  });
  }
  Future<void> initializeData() async {    
    await _loadCartItem();
    calculateTotalAmount();
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }
  List<Cart> getSelectedProducts() {
   return allCartItem.where((cart) => selectedCart.contains(cart.CartId)).toList();
  }
  
 @override
 Widget build(BuildContext context) {
  return WillPopScope(   //nút quay lại trên điện thoại <
    onWillPop: () async {
      Navigator.pop(context, true);
      return true;
    },
    child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: Colors.pink[50],
          title: const Text("Giỏ hàng",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
       ),
        body: allCartItem.isEmpty? 
        const Center(
          child: Text('Không có sản phẩm trong giỏ hàng',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allCartItem.length,    // lấy số lượng sản phẩm trong giỏ hàng
                    itemBuilder: (context, index) {
                      return CartItem(
                        cart: allCartItem[index],
                        isSelected: selectedCart.contains(allCartItem[index].CartId),
                        onSelect: (selected) {       // onselect kiểm tra xem sản phẩm đó có được chọn ko
                          setState(() {   
                            if (selected) {
                              selectedCart.add(allCartItem[index].CartId);
                            } else {
                              selectedCart.remove(allCartItem[index].CartId);
                            }
                            calculateTotalAmount();
                          });
                        },
                        onUpdate: (updatedCart) {     // nếu có thay đổi về số lượng hay xóa thì load lại danh sách sp trên giỏ hàng và tổng tiền
                          _loadCartItem();
                          calculateTotalAmount();
                        },
                        calculateTotalAmount: calculateTotalAmount,  //tính tổng tiền sản phẩm dc chọn
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: const  BoxDecoration(
                    color: Colors.white,
                    border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0),),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng tiền:", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                            Text("${intToString(totalAmount)}đ", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                            ]
                        ),
                       SizedBox(height: 10,),
                       Row(
                        children: [
                        Expanded(
                          child: ElevatedButton.icon(
                          onPressed: () async {
                            List<Cart> _carts= getSelectedProducts();
                              
                              if (_carts.length== 0) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Thông báo'),
                                      content: Text('Vui lòng chọn sản phẩm !'),
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
                              }
                              else
                              {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentScreen(selectedProducts: _carts,Id: widget.Id,
                                    
                                      ),
                                    ),
                                  );
                              }
                            
                            },
                            icon: const Icon(Icons.shopping_cart, color: Colors.black),
                            label: const Text("Mua hàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[300],
                              side: const BorderSide(color: Colors.black),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                    ],
                  ),
                    ]
                  ),
                ),
              ],
            ),
          ),
       );
   }
   
}
