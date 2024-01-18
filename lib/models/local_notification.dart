import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

Future<void> showNotificationOderDelete (String OrderId) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo khi đơn hàng bị hủy',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
     1,
    'Đơn hàng đã bị hủy',
    'Bạn đã hủy đơn hàng ${OrderId} thành công.',
    platformChannelSpecifics,
    payload: 'item x',
  );
}