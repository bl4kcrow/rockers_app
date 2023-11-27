import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pushNotificationsProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3.0,
            blurRadius: 2.0,
            offset: const Offset(0.0, 1.0), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Insets.large,
        vertical: Insets.medium,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.whatshot_outlined,
              ),
              label: AppConstants.trendingLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_library_outlined,
              ),
              label: AppConstants.playlistsLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline,
              ),
              label: AppConstants.infoLabel,
            ),
          ],
          onTap: onTap,
        ),
      ),
    );
  }
}
