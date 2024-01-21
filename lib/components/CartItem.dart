
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItem extends StatefulWidget {
  final Cart cart;
  final bool isSelected;
  final Function(bool) onSelect;
  final Function(Cart) onUpdate;
  final VoidCallback calculateTotalAmount; // Thêm thuộc tính này

  CartItem({
    Key? key,
    required this.cart,
    required this.onUpdate,
    required this.isSelected,
    required this.onSelect,
    required this.calculateTotalAmount, // Thêm đối số này vào constructor
  }) : super(key: key);
  @override
  State<CartItem> createState() => _CartItemState();

}
class _CartItemState extends State<CartItem> {
  bool selected = false;

  DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('carts');

  void deleteProductCart(String id) {
    cartRef.child(id).remove().then((_) {
      widget.onUpdate(widget.cart);
      widget.calculateTotalAmount(); // Bỏ qua giá trị số lượng khi xóa
    }).catchError((error) {
      print('Lỗi khi xóa: $error');
    });
  }

 void updateProductQuantity(String cartId, int newQuantity) {
  if (newQuantity >= 1) {
    cartRef.child(cartId).update({'quantity': newQuantity}).then((_) {
      widget.onUpdate(widget.cart);
      updateSelected(widget.cart.isSelected); // Cập nhật trạng thái đã chọn
      setState(() {
        widget.calculateTotalAmount(); // Tính lại tổng tiền
      });
    }).catchError((error) {
      print('Lỗi khi cập nhật số lượng: $error');
    });
  }
}
  void updateSelected(bool value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10),
      child: Row(
        children: [
          Slidable(
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.transparent,
                    onPressed: (context) {
                      setState(() {
                        deleteProductCart(widget.cart.CartId);
                      });
                    },
                    label: "Xóa",
                    icon: Icons.delete_forever,
                    foregroundColor: Colors.red,
                  ),
                ]),
            child: Container(
              height: 147,
              width: MediaQuery.of(context).size.width - 10,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: (value) {
                      widget.onSelect(value ?? false);
                      widget.cart.isSelected = value ?? false;
                      widget.onUpdate(widget.cart); 
                    },
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.cart.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.cart.productName,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (widget.cart.promotion > 0)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${widget.cart.price}đ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text('  ${widget.cart.promotion}đ',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            if ((widget.cart.promotion == 0) &&
                                widget.cart.price > 0)
                              Text(
                                '${widget.cart.price}đ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    updateProductQuantity(
                                        widget.cart.CartId,
                                        widget.cart.quantity - 1);
                                        
                                  });
                                },
                              ),
                              Text('${widget.cart.quantity}',
                                  style: TextStyle(fontSize: 17)),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    updateProductQuantity(
                                        widget.cart.CartId,
                                        widget.cart.quantity + 1); 
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

