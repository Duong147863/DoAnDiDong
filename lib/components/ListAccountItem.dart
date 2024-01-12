import 'package:flutter/material.dart';

class AccountInfoContainer extends StatefulWidget {
  final String name;
  final String email;

  const AccountInfoContainer({required this.name, required this.email});

  @override
  _AccountInfoContainerState createState() => _AccountInfoContainerState();
}

class _AccountInfoContainerState extends State<AccountInfoContainer> {
  bool isSwitched = true; // mặc định trạng thái switch là bật

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSwitched ? Colors.pink[50] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),      // Độ trong suốt 50%
            spreadRadius: 1,         // Xác định mức độ mà bóng sẽ lan rộng
            blurRadius: 4,          // Bán kính mờ xác định độ mờ của bóng
            offset: Offset(0, 2),      // Khoảng cách mà bóng sẽ được dịch chuyển
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isSwitched ? Icons.task_alt : Icons.cancel_outlined,
            color: isSwitched ? Colors.blue : Colors.red,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.name}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('${widget.email}',
                style:const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Switch(
            value: isSwitched,
            activeColor: Colors.pink,
            onChanged: (value) {
              _showAlertDialog(value);
            },
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(bool newValue) {
  showDialog(       // Hiển thị hộp thoại
    context: context,
    builder: (BuildContext context) {
      return _AlertDialog(isSwitched: newValue);  
    },
  ).then((confirmed) {

    // Kiểm tra kết quả của hộp thoại sau khi nó được đóng
    if (confirmed != null && confirmed) {
      // Nếu người dùng nhấn "Đồng ý", thì cập nhật trạng thái của switch
      setState(() {
        isSwitched = newValue;
      });
    }
  });
}
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({ Key? key, required this.isSwitched,}) : super(key: key);
  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.notification_important_outlined, color: Colors.black),
                Text("Thông báo"),
              ],
            ),
          ),
        ],
      ),
      content: Text(
          isSwitched? "Bạn có muốn mở khóa tài khoản này không?" : "Bạn có muốn khóa tài khoản này không?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Đồng ý'),
            ),
          ],
        )
      ],
    );
  }
}
