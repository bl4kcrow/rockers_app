import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  final viewRoutes = const <Widget>[
    TrendingView(),
    PlaylistsView(),
    AboutView(),
  ];

  void _onTap(
    BuildContext context,
    int index,
  ) {
    context.go('${Routes.homeScreen}/$index');
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: AppNavigationBar(
          currentIndex: pageIndex,
          onTap: (int index) => _onTap(
            context,
            index,
          ),
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
