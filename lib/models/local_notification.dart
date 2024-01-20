import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
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

Future<void> showAddProductSuccessNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo khi thực hiện thêm sản phẩm thành công',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Thêm sản phẩm thành công',
    'bạn đã thực hiện thêm sản phẩm thành công',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> showEditProductSuccessNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo khi thực hiện cập nhật sản phẩm thành công',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Cập nhật sản phẩm thành công',
    'bạn đã thực hiện cập nhật thông tin sản phẩm thành công',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> showDeleteProductSuccessNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'order_channel_id',
    'order_channel_name',
    channelDescription: 'Thông báo khi thực hiện xóa sản phẩm thành công',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Xóa sản sản phẩm thành công',
    'bạn đã thực hiện xóa sản phẩm thành công',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
