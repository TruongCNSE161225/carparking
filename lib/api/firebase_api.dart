import 'package:carparkingapp/main.dart';

class FirebaseApi {
  // final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    // await _firebaseMessaging.requestPermission();

    // final fCMToken = await _firebaseMessaging.getToken();
    // print('Token: $fcmToken');
    // initPushNotifications();
  }

  // void handleMessage(RemoteMessage? message) {
  //   if (message == null) return;

  //   navigatorKey.currentState!.pushNamed(
  //     "",
  //     arguments: message,
  //   );
  // }

  // Future initPushNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }
}
