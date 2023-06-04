import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rockers_app/config/config.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({
    super.key,
    required this.videoPlayer,
  });

  final Widget videoPlayer;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SizedBox(
            child: videoPlayer,
          ),
          FloatingActionButton.small(
            onPressed: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
