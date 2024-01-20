import 'package:doandidongappthuongmai/components/Navigation.dart';
import 'package:doandidongappthuongmai/components/GetCart.dart';
import 'package:doandidongappthuongmai/models/notification.dart';
import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:doandidongappthuongmai/view/LoginScreen.dart';
import 'package:doandidongappthuongmai/view/ManageAccountScreen.dart';
import 'package:doandidongappthuongmai/view/OrderDetailScreen.dart';
import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doandidongappthuongmai/models/firebase_options.dart';
import 'package:provider/provider.dart';


  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
final firebaseMessagingService = FirebaseMessagingService();
await firebaseMessagingService.initialize();
  // Khởi tạo MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
       
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.black
      ),
    home: LoginScreen(),
    );
  }
}