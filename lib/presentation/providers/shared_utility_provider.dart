import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rockers_app/config/config.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);

  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  bool isDarkModeEnabled() {
    return sharedPreferences.getBool(AppConstants.sharedDarkModeKey) ?? true;
  }

  void setDarkModeEnabled({
    required bool isdark,
  }) {
    sharedPreferences.setBool(
      AppConstants.sharedDarkModeKey,
      isdark,
    );
  }

  bool isAutoplayEnabled() {
    return sharedPreferences.getBool(AppConstants.sharedAutoplayKey) ?? false;
  }

  void setAutoplayEnabled({
    required bool isAutoplayEnabled,
  }) {
    sharedPreferences.setBool(
      AppConstants.sharedAutoplayKey,
      isAutoplayEnabled,
    );
  }
}
