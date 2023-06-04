import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final bool isDarkMode = ref.watch(appThemeProvider).isDarkMode;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isDarkMode
                  ? AppConstants.onlyGuitarWhiteLogo
                  : AppConstants.onlyGuitarBlackLogo,
              height: screenSize.width * 0.3,
            ),
            Text(
              AppConstants.rockers,
              style: textTheme.titleLarge?.copyWith(
                fontFamily: 'ManoNegra',
              ),
              textScaleFactor: AppConstants.textScaleFactor,
            ),
            Text(
              AppConstants.letTheRockLabel,
              style: textTheme.titleLarge?.copyWith(
                fontFamily: 'ManoNegra',
              ),
            ),
            const SizedBox(height: Insets.large),
            const Text(AppConstants.spreadingRockLabel),
            const Text(AppConstants.bl4kcrowCopyright),
            const Text(AppConstants.appVersionLabel),
          ],
        ),
      ),
    );
  }
}
