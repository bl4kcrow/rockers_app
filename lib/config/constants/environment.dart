import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String firebaseWebApiKey = dotenv.get(
    'FIREBASE_WEB_APIKEY',
  );
  static final String firebaseAndroidApiKey = dotenv.get(
    'FIREBASE_ANDROID_APIKEY',
  );
  static final String firebaseIosApiKey = dotenv.get(
    'FIREBASE_IOS_APIKEY',
  );
  static final String firebaseAppId = dotenv.get(
    'FIREBASE_APPID',
  );
  static final String firebaseAndroidClientId = dotenv.get(
    'FIREBASE_ANDROID_CLIENT_ID',
  );
  static final String firebaseIosClientId = dotenv.get(
    'FIREBASE_IOS_CLIENT_ID',
  );
}
