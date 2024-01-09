import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: const Text("Giỏ hàng của tôi",style: TextStyle(color: Colors.black, fontSize: 25),),
        
        iconTheme: const IconThemeData(color: Colors.black), 
      ),
    );
  }
}
