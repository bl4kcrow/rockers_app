import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
class AppUpdateScreen extends ConsumerWidget {
  const AppUpdateScreen({super.key});

  // void _launchAppPlayStore() {
  //   final url = Uri.parse('market://details?id=${AppConstants.playStoreAppId}');

  //   launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = ref.watch(appThemeProvider).isDarkMode;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Insets.extraLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.25),
            Image.asset(
              isDarkMode
                  ? AppConstants.onlyGuitarWhiteLogo
                  : AppConstants.onlyGuitarBlackLogo,
              height: screenSize.width * 0.15,
              semanticLabel: SemanticLabels.rockersLogo,
            ),
            SizedBox(height: Insets.medium),
            Text(
              AppConstants.updateAppLabel,
              style: textTheme.headlineLarge,
            ),
            SizedBox(height: Insets.medium),
            Text(AppConstants.updateAppText, style: textTheme.labelLarge),
            Spacer(),
            Center(
              child: SizedBox(
                width: screenSize.width * 0.6,
                child: ElevatedButton(
                  onPressed: launchAppPlayStore,
                  child: const Text(AppConstants.updateNowLabel),
                ),
              ),
            ),
            const SizedBox(height: Insets.extraLarge),
          ],
        ),
      ),
    );
  }
}
