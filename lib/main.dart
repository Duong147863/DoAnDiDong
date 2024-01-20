import 'package:doandidongappthuongmai/components/AddProduct.dart';
import 'package:doandidongappthuongmai/components/EditProdcut.dart';
import 'package:doandidongappthuongmai/components/OrderHistory.dart';
import 'package:doandidongappthuongmai/components/ProfileManageProduct.dart';
import 'package:doandidongappthuongmai/components/PurchasedProduct.dart';
import 'package:doandidongappthuongmai/models/notification.dart';
import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/ManageProduct.dart';
import 'package:doandidongappthuongmai/view/MyOrderScreen.dart';
import 'package:doandidongappthuongmai/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doandidongappthuongmai/models/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      routes: {
        "/": (context) => MyOrder(),
        "/home": (context) => MainScreen(),
        "/addpro": (context) => AddProduct(),
        "/editpro": (context) => EditProduct(
              productId: "",
              catId: "",
              idPro: "",
              image: "",
            ),
        "/profilemanagepro": (context) => ProfileManageProduct(
              searchQuery: '',
            ),
        "Purpro": (context) => PurchasedProduct(),
        "/managepro": (context) => ManageProduct(),
        "/myorder": (context) => MyOrder(),
        "/oderhistory": (context) => OrderHistory(),
        "/manageaccount": (context) => ManageScreen(),
        "/profile": (context) => ProfileScreen(),
      },
      initialRoute: '/',
    );
  }
}
