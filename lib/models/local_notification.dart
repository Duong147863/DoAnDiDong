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
    channelDescription: 'Thông báo khi thực hiện mở tài khoản',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Mở tài khoản thành công',
    'Tài khoản $displayName đã mở khóa ',
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
