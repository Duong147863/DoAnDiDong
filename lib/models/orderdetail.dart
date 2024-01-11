import 'package:flutter/material.dart';

class OrderDetails {
  final String image;
  final String productName;
  final String price;
  final int Quantity;
  final String name;
  final String phone;
  final String address;
  final String typePayment;
  final String productmoney;
  final String deliverycharges;
  final String totalPayment;

  OrderDetails({
    required this.image,
    required this.productName,
    required this.price,
    required this.Quantity,
    required this.name,
    required this.phone,
    required this.address,
    required this.typePayment,
    required this.productmoney,
    required this.deliverycharges,
    required this.totalPayment

  });
}