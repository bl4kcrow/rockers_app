import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/utils/firebase_options.dart';
import 'package:rockers_app/domain/domain.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint("Handling a background message: ${message.messageId}");
}

final pushNotificationsProvider =
    StateNotifierProvider<PushNotificationsNotifier, NotificationsState>((ref) {
  return PushNotificationsNotifier();
});

class PushNotificationsNotifier extends StateNotifier<NotificationsState> {
  PushNotificationsNotifier()
      : super(NotificationsState(
          status: AuthorizationStatus.notDetermined,
        )) {
    _initialStatusCheck();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();

    state = state.copyWith(status: settings.authorizationStatus);
    if (state.status == AuthorizationStatus.authorized) {
      final token = await getFCMToken();
      debugPrint('FCM Token: $token');
    }
  }

  Future<String> getFCMToken() async {
    final String token = await messaging.getToken() ?? '';

    return token;
  }
}
