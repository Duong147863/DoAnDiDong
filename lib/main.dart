import 'package:doandidongappthuongmai/components/GetCart.dart';
import 'package:doandidongappthuongmai/models/notification.dart';
import 'package:doandidongappthuongmai/view/LoginScreen.dart';
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
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
