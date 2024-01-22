import 'package:doandidongappthuongmai/components/ListNotificationItem.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String userId;

  const NotificationScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> notifications = [];

  Future<void> _refresh() async {
    // Thực hiện các thao tác làm mới ở đây
    await loadNotification();
  }

  @override
  void initState() {
    super.initState();
    loadNotification();
  }

  Future<void> loadNotification() async {
    List<NotificationData> noti = await NotificationData.fetchNotifications(widget.userId);

    // Sắp xếp danh sách theo thời gian giảm dần
    noti.sort((a, b) => b.time.compareTo(a.time));
    // Chọn tối đa 10 thông báo mới nhất
    notifications = noti.take(10).toList();
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Center(
          child: Text(
            "Thông báo",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Cập nhật thông báo"),
                    TextButton(
                      onPressed: () {
                          NotificationData.deleteNotifications(widget.userId);
                          setState(() {
                            
                            _refresh();
                          });
                      },
                      child: Text(
                        "Xóa tất cả",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.grey[350]),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NotificationItem(
                    data: notifications[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
