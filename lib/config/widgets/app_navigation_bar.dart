import 'package:flutter/material.dart';

import 'package:rockers_app/config/config.dart';
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(
          label: AppConstants.trendingLabel,
          icon: Icon(Icons.whatshot),
          selectedIcon: Icon(Icons.whatshot_outlined),
        ),
        NavigationDestination(
          label: AppConstants.playlistsLabel,
          icon: Icon(Icons.subscriptions),
          selectedIcon: Icon(Icons.subscriptions_outlined),
        ),
        NavigationDestination(
          label: AppConstants.infoLabel,
          icon: Icon(Icons.info),
          selectedIcon: Icon(Icons.info_outline),
        ),
      ],
      onDestinationSelected: onTap,
    );
  }
}
