import 'package:doandidongappthuongmai/components/Navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  //Messagse thông báo
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                  labelText: 'Tài khoản',
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(60, 13, 60, 13)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.pinkAccent),
                  ),
                  onPressed: _signIn,
                  child: Text(
                    "Đăng Nhập",
                    textAlign: TextAlign.center,
                  ),
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

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials();
  }

  //Hàm lưu dữ liệu tại local
  Future<void> _loadStoredCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('storedEmail');
    String? storedPassword = prefs.getString('storedPassword');
    if (storedEmail != null &&
        storedEmail.isNotEmpty &&
        storedPassword != null &&
        storedPassword.isNotEmpty) {
      // Nếu có email đã lưu, bạn có thể tự động điền vào trường email
      // và tiếp tục quá trình đăng nhập
      _usernameController.text = storedEmail;
      _passwordController.text = storedPassword;
    }
  }

  //Hàm đăng nhập
  void _signIn() async {
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      _isSigning = true;
    });

    String email = _usernameController.text;
    String password = _passwordController.text;

    // Kiểm tra tính hợp lệ của tài khoản và mật khẩu
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, 'Vui lòng nhập tài khoản và mật khẩu.');
      if (mounted) {
        setState(() {
          _isSigning = false;
        });
      }
      return;
    }

    // Thực hiện đăng nhập với Firebase
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (mounted) {
      setState(() {
        _isSigning = false;
      });
    }

    if (user != null) {
      // Lấy ID của người dùng đã đăng nhập
      String userId = user.uid;

      // Get the 'status' from the database for the logged-in user
      bool userStatus = await _auth.getUserStatus(userId);

      if (userStatus) {
        // Account is active, proceed to HomeScreen
        _auth.setUserName(email);

        // Save email to local storage for automatic login
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('storedEmail', email);
        prefs.setString('storedPassword', password);
        // Pass user ID to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationScreen(userId: userId),
          ),
        );
      } else {
        // Account is inactive, show a message or handle accordingly
        print("Đăng nhập thất bại: Tài khoản đã bị khóa.");
        showSnackBar(context, 'Tài khoản đã bị khóa.');
      }
    } else {
      print("Đăng nhập thất bại: Tài khoản hoặc mật khẩu không chính xác.");
      showSnackBar(context, 'Tài khoản hoặc mật khẩu không chính xác.');
    }
  }
}

//DiaLog Giao Diện Đăng Kí
class RegisterDialog {
  static Future<void> showRegisterDialog(BuildContext context) async {
    void showSnackBar1(String message) {
      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.pink,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
                      controller: confirmPasswordController,
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
                onPressed: () async {
                  // Xử lý đăng ký ở đây
                  String username = usernameController.text;
                  bool isValidPhoneNumber(String phoneNumber) {
                    return phoneNumber.trim().length == 10 &&
                        int.tryParse(phoneNumber) != null;
                  }

                  String phoneNumber = phoneNumberController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  bool status = true;

                  // Kiểm tra xem mọi TextField đã được điền đầy đủ thông tin chưa
                  if (username.isEmpty ||
                      phoneNumber.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      confirmPassword.isEmpty) {
                    print("Vui lòng điền đầy đủ thông tin");
                    showSnackBar1( 'Vui lòng điền đầy đủ thông tin');
                    return;
                  }
                  if (!isValidPhoneNumber(phoneNumber)) {
                    print("Số điện thoại không hợp lệ");
                    showSnackBar1( 'Số điện thoại không hợp lệ');
                    return;
                  }

                  // Kiểm tra xem mật khẩu có khớp không
                  if (password.trim() != confirmPassword.trim()) {
                    print("Mật khẩu và mật khẩu nhập lại không khớp");
                    showSnackBar1(
                         'Mật khẩu và mật khẩu nhập lại không khớp');
                    return;
                  }
                  // Gọi hàm đăng ký từ FirebaseAuthService
                  FirebaseAuthService authService = FirebaseAuthService();
                  // Kiểm tra xem số điện thoại đã sử dụng chưa
                  bool isPhoneNumberUsed =
                      await authService.isPhoneNumberUsed(phoneNumber);
                  if (isPhoneNumberUsed) {
                    print("Số điện thoại đã được sử dụng");
                    showSnackBar1( 'Số điện thoại đã được sử dụng');
                    return;
                  }
                  User? user = await authService.signUpWithEmailAndPassword(
                      username, phoneNumber, email, password, status);
                  // Kiểm tra xem đăng ký có thành công hay không
                  if (user != null) {
                    print("Đăng ký thành công");
                    showSnackBar1( 'Đăng ký thành công');
                  } else {
                    print("Đăng ký thất bại");
                    showSnackBar1('Đăng ký thất bại');
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Lớp lấy trạng thái status của user
class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> getUserStatus(String userId) async {
    try {
      DataSnapshot statusSnapshot = (await FirebaseDatabase.instance
              .reference()
              .child('users')
              .child(userId)
              .child('status')
              .once())
          .snapshot;

      return (statusSnapshot.value as bool?) ?? false;
    } catch (e) {
      print("Error getting user status: $e");
      return false;
    }
  }
  //Kiểm tra có số điện thoại trên firebase
  Future<bool> isPhoneNumberUsed(String phoneNumber) async {
    try {
      DatabaseEvent snapshotEvent = await FirebaseDatabase.instance
          .reference()
          .child('users')
          .orderByChild('phoneNumber')
          .equalTo(phoneNumber)
          .once();

      if (snapshotEvent.snapshot != null) {
        DataSnapshot snapshot = snapshotEvent.snapshot;
        return snapshot.value != null;
      }

      return false;
    } catch (e) {
      print("Error checking phone number: $e");
      return false;
    }
  }
  //Đăng nhập xử lí firebase
  Future<User?> signUpWithEmailAndPassword(String username, String phoneNumber,
      String email, String password, bool status) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user?.uid ?? "";

      saveUserData(uid, username, phoneNumber, email, status);

      return userCredential.user;
    } catch (e) {
      print("Error during registration: $e");
      return null;
    }
  }

// Lưu thông tin người dùng vào Realtime Database
  void saveUserData(String uid, String username, String phoneNumber,
      String email, bool status) {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users').child(uid);
    userRef.set({
      'displayName': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'status': true,
      'persission': false
    });
  }

//Xử lý dữ liệu đăng kí
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

  Future<void> setUserName(String username) async {}

  Future<String> getUserName() async {
    return "";
  }
}
