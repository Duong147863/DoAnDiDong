import 'package:doandidongappthuongmai/models/load_data.dart';

class OrderDetails {
  final String OrderId;
  final List<Cart> products; // Thêm danh sách sản phẩm
  final String name;
  final String phone;
  final String address;
  final String typePayment;
  final String productmoney;
  final String deliverycharges;
  final String totalPayment;
  final String status;

  OrderDetails({
    required this.OrderId,
    required this.products,
    required this.name,
    required this.phone,
    required this.address,
    required this.typePayment,
    required this.productmoney,
    required this.deliverycharges,
    required this.totalPayment,
    required this.status,
  });
}
