import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rockers_app/config/config.dart';

class AppTheme {
  AppTheme({
    this.isDarkMode = true,
  });

  final bool isDarkMode;

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.eerieBlack.withValues(alpha: 0.8),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.eerieBlack,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.eerieBlack,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      canvasColor: AppColors.smokyBlack.withValues(alpha: 0.7),
      cardTheme: const CardTheme(
        color: AppColors.smokyBlack,
      ),
      chipTheme: const ChipThemeData(
        side: BorderSide.none,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.frenchWine,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.eerieBlack,
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.oldMauve,
        onSecondary: AppColors.white,
        tertiary: AppColors.frenchWine,
        onTertiary: AppColors.white,
        surface: AppColors.eerieBlack,
        surfaceTint: AppColors.smokyBlack,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.eerieBlack,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        expandedAlignment: Alignment.centerLeft,
        tilePadding: EdgeInsets.symmetric(
          horizontal: Insets.small,
        ),
        childrenPadding: EdgeInsets.symmetric(
          horizontal: Insets.medium,
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(Insets.small),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(Insets.small),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.eerieBlack,
        foregroundColor: AppColors.white,
      ),
      fontFamily: 'Kollektif',
      iconTheme: const IconThemeData(color: AppColors.frenchWine),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.eerieBlack,
        elevation: 0.0,
        indicatorColor: AppColors.frenchWine,
      ),
      textTheme: Typography().white.copyWith(
            displayLarge: AppTextStyle.displayLarge.copyWith(
              color: AppColors.white,
            ),
            displayMedium: AppTextStyle.displayMedium.copyWith(
              color: AppColors.white,
            ),
            displaySmall: AppTextStyle.displaySmall.copyWith(
              color: AppColors.white,
            ),
            headlineLarge: AppTextStyle.headlineLarge.copyWith(
              color: AppColors.white,
            ),
            headlineMedium: AppTextStyle.headlineMedium.copyWith(
              color: AppColors.white,
            ),
            headlineSmall: AppTextStyle.headlineSmall.copyWith(
              color: AppColors.white,
            ),
            titleLarge: AppTextStyle.titleLarge.copyWith(
              color: AppColors.white,
            ),
            titleMedium: AppTextStyle.titleMedium.copyWith(
              color: AppColors.white,
            ),
            titleSmall: AppTextStyle.titleSmall.copyWith(
              color: AppColors.white,
            ),
            bodyLarge: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.white,
            ),
            bodyMedium: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.white,
            ),
            bodySmall: AppTextStyle.bodySmall.copyWith(
              color: AppColors.white,
            ),
          ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white.withValues(alpha: 0.8),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      canvasColor: AppColors.white.withValues(alpha: 0.7),
      cardTheme: const CardTheme(
        color: AppColors.white,
      ),
      chipTheme: const ChipThemeData(
        side: BorderSide.none,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.frenchWine,
        onPrimary: AppColors.smokyBlack,
        primaryContainer: AppColors.eerieBlack,
        onPrimaryContainer: AppColors.smokyBlack,
        secondary: AppColors.oldMauve,
        onSecondary: AppColors.smokyBlack,
        tertiary: AppColors.frenchWine,
        onTertiary: AppColors.smokyBlack,
        surface: AppColors.white,
        surfaceTint: AppColors.white,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.eerieBlack,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        expandedAlignment: Alignment.centerLeft,
        tilePadding: EdgeInsets.symmetric(
          horizontal: Insets.small,
        ),
        childrenPadding: EdgeInsets.symmetric(
          horizontal: Insets.medium,
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.outerSpace),
          borderRadius: BorderRadius.circular(Insets.small),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.outerSpace),
          borderRadius: BorderRadius.circular(Insets.small),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.oldMauve,
      ),
      fontFamily: 'Kollektif',
      iconTheme: const IconThemeData(color: AppColors.oldMauve),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        indicatorColor: AppColors.frenchWine,
      ),
      textTheme: Typography().black.copyWith(
            displayLarge: AppTextStyle.displayLarge.copyWith(
              color: AppColors.smokyBlack,
            ),
            displayMedium: AppTextStyle.displayMedium.copyWith(
              color: AppColors.smokyBlack,
            ),
            displaySmall: AppTextStyle.displaySmall.copyWith(
              color: AppColors.smokyBlack,
            ),
            headlineLarge: AppTextStyle.headlineLarge.copyWith(
              color: AppColors.smokyBlack,
            ),
            headlineMedium: AppTextStyle.headlineMedium.copyWith(
              color: AppColors.smokyBlack,
            ),
            headlineSmall: AppTextStyle.headlineSmall.copyWith(
              color: AppColors.smokyBlack,
            ),
            titleLarge: AppTextStyle.titleLarge.copyWith(
              color: AppColors.smokyBlack,
            ),
            titleMedium: AppTextStyle.titleMedium.copyWith(
              color: AppColors.smokyBlack,
            ),
            titleSmall: AppTextStyle.titleSmall.copyWith(
              color: AppColors.smokyBlack,
            ),
            bodyLarge: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.smokyBlack,
            ),
            bodyMedium: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.eerieBlack,
            ),
            bodySmall: AppTextStyle.bodySmall.copyWith(
              color: AppColors.eerieBlack,
            ),
          ),
    );
  }

  AppTheme copyWith({
    bool? isDarkMode,
  }) =>
      AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  ThemeData getTheme() {
    if (isDarkMode == true) {
      return dark();
    } else {
      return light();
    }
  }
}
