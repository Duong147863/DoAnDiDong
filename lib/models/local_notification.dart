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

Future<void> showEditProfileNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo sửa thông tin cá nhân thành công',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Sửa thông tin thành công',
    'Hãy kiểm tra lại thông tin của bạn!',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
