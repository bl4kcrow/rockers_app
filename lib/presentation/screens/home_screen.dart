import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

class HomeScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAppVersioning = ref.watch(appVersioningProvider);
    FlutterNativeSplash.remove();

    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: asyncAppVersioning.when(
        data: (appVersioning) =>
            appVersioning.updateStatus == AppUpdateStatus.mandatory
                ? AppUpdateScreen()
                : Scaffold(
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
        error: (_, __) => Scaffold(
          body: Center(
            child: Text(
              AppConstants.errorLoadingTheApp,
            ),
          ),
        ),
        loading: () => Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
