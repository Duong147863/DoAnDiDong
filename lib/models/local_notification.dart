import 'package:doandidongappthuongmai/view/PayProductScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:doandidongappthuongmai/components/ListAccountItem.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

Future<void> showOrderSuccessNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo khi đơn hàng được đặt thành công',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Đặt hàng thành công',
    'Cảm ơn bạn đã đặt hàng. Hãy kiểm tra đơn hàng của bạn!',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
Future<void> NotificationOfLockedAccount(String displayName) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    1,
    'Khóa tài khoản thành công',
    'Tài khoản $displayName đã bị khóa ',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
Future<void> AccountUnlockNotification(String displayName) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    2,
    'Mở khóa tài khoản thành công',
    'Tài khoản $displayName đã được mở khóa ',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

