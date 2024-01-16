import 'package:doandidongappthuongmai/view/ProductDetailScreen.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  int _totalCartQuantity = 0;

  int get totalCartQuantity => _totalCartQuantity;
  Future<void> loadCartQuantity() async {
    int quantity = await getCartItemCount();
    _totalCartQuantity = quantity;
    notifyListeners(); // Thông báo về sự thay đổi đến các người nghe
  }
  void updateCartQuantity(int newQuantity) {
    _totalCartQuantity = newQuantity;
    notifyListeners(); // Thông báo về sự thay đổi đến các người nghe
  }
}