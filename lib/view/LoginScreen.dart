import 'package:doandidongappthuongmai/view/HomeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isSigning = false;
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message,
            style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
        backgroundColor: Colors.pink);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          widthFactor: double.infinity,
          heightFactor: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  "Đăng Nhập",
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Đăng Nhập',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.pinkAccent),
                  ),
                  onPressed: _signIn,
                  child: Text("Đăng Nhập"),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Hoặc")),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: RichText(
                  text: TextSpan(
                    text: 'Bạn chưa có tài khoản? ',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Đăng ký',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            RegisterDialog.showRegisterDialog(context);
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _usernameController.text;
    String password = _passwordController.text;

    // Kiểm tra tính hợp lệ của tài khoản và mật khẩu
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, 'Vui lòng nhập tài khoản và mật khẩu.');
      setState(() {
        _isSigning = false;
      });
      return;
    }

    // Thực hiện đăng nhập với Firebase
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      _auth.setUserName(email);
      print("User is successfully signed in");
      Navigator.pushReplacementNamed(context as BuildContext, "/home");
    } else {
      print("Đăng nhập thất bại: Tài khoản hoặc mật khẩu không chính xác.");
      showSnackBar(context, 'Tài khoản hoặc mật khẩu không chính xác.');
    }
  }
}

class RegisterDialog {
  static Future<void> showRegisterDialog(BuildContext context) async {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          widthFactor: double.infinity,
          heightFactor: double.infinity,
          child: AlertDialog(
            title: Text(
              'Đăng ký',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: 'Họ và Tên',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Tài khoản',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Mật khẩu nhập lại',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Đăng ký'),
                onPressed: () async  {
                  // Xử lý đăng ký ở đây
                  String username = usernameController.text;
                  String phoneNumber = phoneNumberController.text;
                  String email = emailController.text;
                  String password = passwordController.text;

                   // Gọi hàm đăng ký từ FirebaseAuthService
                  FirebaseAuthService authService = FirebaseAuthService();
                  User? user = await authService.signUpWithEmailAndPassword(
                    username,
                    phoneNumber,
                    email,
                    password,
                  );
                   // Kiểm tra xem đăng ký có thành công hay không
                  if (user != null) {
                    print("Đăng ký thành công");
                  } else {
                    print("Đăng ký thất bại");
                  }

                  // Đóng hộp thoại
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // static void _handleRegistration(String username, String password) {
  //   // Xử lý đăng ký, bạn có thể thực hiện các bước xác minh và lưu trữ thông tin đăng ký ở đây
  //   print('Đăng ký với tên người dùng: $username và mật khẩu: $password');
  // }
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
  String username,
  String phoneNumber,
  String email,
  String password,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user?.uid ?? "";
    saveUserData(uid, username, phoneNumber);
    return userCredential.user;
  } catch (e) {
    print("Error during registration: $e");
  }
}

// Lưu thông tin người dùng vào Realtime Database
  void saveUserData(String uid, String username, String phoneNumber) {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users').child(uid);
    userRef.set({
      'displayName': username,
      'phoneNumber': phoneNumber,
    });
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some Error $e");
    }
  }

  Future<void> setUserName(String username) async {
    // Your setUserName logic goes here
  }

  Future<String> getUserName() async {
    // Your getUserName logic goes here
    return "";
  }
}
