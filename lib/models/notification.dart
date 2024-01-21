import 'package:doandidongappthuongmai/models/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received FCM message: ${message.notification?.title}');
      // Hiển thị thông báo khi có tin nhắn mới từ FCM
     showOrderSuccessNotification();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened by FCM message: ${message.notification?.title}');
      // Xử lý khi người dùng nhấp vào thông báo khi ứng dụng đang mở
    });
  }

  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }
}
