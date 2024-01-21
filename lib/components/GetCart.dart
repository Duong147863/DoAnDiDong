import 'package:doandidongappthuongmai/view/ProductDetailScreen.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  int _totalCartQuantity = 0;

  int get totalCartQuantity => _totalCartQuantity;
  Future<void> loadCartQuantity(String userId) async {
    int quantity = await getCartItemCount(userId);
    _totalCartQuantity = quantity;
    notifyListeners(); // Thông báo về sự thay đổi đến các người nghe
  }
  void updateCartQuantity(int newQuantity) {
    _totalCartQuantity = newQuantity;
    notifyListeners(); // Thông báo về sự thay đổi đến các người nghe
  }
}