import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

final appRouter = GoRouter(
  initialLocation: '${Routes.homeScreen}/0',
  routes: [
    GoRoute(
      path: '${Routes.homeScreen}/:page',
      name: Routes.homeScreen,
      builder: (context, state) {
        final int pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: Routes.videoPlaybackScreen,
          name: Routes.videoPlaybackScreen,
          builder: (context, state) {
            Map<String, Object> args = state.extra as Map<String, Object>;

            return VideoPlaybackScreen(
              bottomWidget: args['bottomWidget'] as Widget,
            );
          },
        ),
      ],
    ),
  ],
);
