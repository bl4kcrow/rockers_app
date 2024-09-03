import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';

class VideoTitle extends ConsumerWidget {
  const VideoTitle({
    super.key,
    required this.band,
    required this.title,
  });

  final String band;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            band,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleLarge,
            textScaler: const TextScaler.linear(AppConstants.textScaleFactor),
            semanticsLabel: band,
          ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            semanticsLabel: title,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
