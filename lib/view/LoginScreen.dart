import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    backgroundColor:
                        MaterialStateProperty.all(Colors.pinkAccent),
                  ),
                  onPressed: () {},
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
}

class RegisterDialog {
  static Future<void> showRegisterDialog(BuildContext context) async {
    TextEditingController usernameController = TextEditingController();
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
                  color: Colors.pinkAccent, fontWeight: FontWeight.bold,fontSize: 30.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Họ và Tên',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Số điện thoại',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Tài khoản',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Mật khẩu',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Mật khẩu nhập lại',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                onPressed: () {
                  // Xử lý đăng ký ở đây
                  String username = usernameController.text;
                  String password = passwordController.text;

                  // Gọi hàm xử lý đăng ký hoặc chuyển thông tin tới nơi cần thiết
                  _handleRegistration(username, password);

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

  static void _handleRegistration(String username, String password) {
    // Xử lý đăng ký, bạn có thể thực hiện các bước xác minh và lưu trữ thông tin đăng ký ở đây
    print('Đăng ký với tên người dùng: $username và mật khẩu: $password');
  }
}
