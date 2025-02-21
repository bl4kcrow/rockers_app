import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  const Environment._({
    required this.firebaseAppId,
    required this.firebaseAndroidApiKey,
    required this.firebaseIosApiKey,
    required this.firebaseWebApiKey,
    required this.firebaseAndroidClientId,
    required this.firebaseIosClientId,
  });

  final String firebaseAppId;
  final String firebaseAndroidApiKey;
  final String firebaseIosApiKey;
  final String firebaseWebApiKey;
  final String firebaseAndroidClientId;
  final String firebaseIosClientId;

  factory Environment.dev() => Environment._(
        firebaseAppId: dotenv.get('FIREBASE_APPID_DEV'),
        firebaseAndroidApiKey: dotenv.get('FIREBASE_ANDROID_APIKEY_DEV'),
        firebaseIosApiKey: dotenv.get('FIREBASE_IOS_APIKEY_DEV'),
        firebaseWebApiKey: dotenv.get('FIREBASE_WEB_APIKEY_DEV'),
        firebaseAndroidClientId: dotenv.get('FIREBASE_ANDROID_CLIENT_ID_DEV'),
        firebaseIosClientId: dotenv.get('FIREBASE_IOS_CLIENT_ID_DEV'),
      );

  factory Environment.prod() => Environment._(
        firebaseAppId: dotenv.get('FIREBASE_APPID'),
        firebaseAndroidApiKey: dotenv.get('FIREBASE_ANDROID_APIKEY'),
        firebaseIosApiKey: dotenv.get('FIREBASE_IOS_APIKEY'),
        firebaseWebApiKey: dotenv.get('FIREBASE_WEB_APIKEY'),
        firebaseAndroidClientId: dotenv.get('FIREBASE_ANDROID_CLIENT_ID'),
        firebaseIosClientId: dotenv.get('FIREBASE_IOS_CLIENT_ID'),
      );
}

