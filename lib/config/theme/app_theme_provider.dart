import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/theme/app_theme.dart';
import 'package:rockers_app/presentation/presentation.dart';

final appThemeProvider =
    StateNotifierProvider<AppThemeNotifier, AppTheme>((ref) {
  return AppThemeNotifier(ref);
});

class AppThemeNotifier extends StateNotifier<AppTheme> {
  AppThemeNotifier(this.ref)
      : super(
          AppTheme(
            isDarkMode: ref.watch(sharedUtilityProvider).isDarkModeEnabled(),
          ),
        );

  Ref ref;

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    ref
        .watch(sharedUtilityProvider)
        .setDarkModeEnabled(isdark: state.isDarkMode);
  }
}
