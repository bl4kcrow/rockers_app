import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final bool isDarkMode = ref.watch(appThemeProvider).isDarkMode;
    AsyncValue<PackageInfo> appInfo = ref.watch(appInfoProvider);

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
              semanticLabel: SemanticLabels.rockersLogo,
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
            Text('${AppConstants.bl4kcrowCopyright} ${DateTime.now().year}'),
            appInfo.when(
              data: (info) => Text('${info.version}+${info.buildNumber}'),
              error: (_, __) => const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
