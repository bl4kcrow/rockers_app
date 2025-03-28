import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';

class OptionalAppUpdateCard extends ConsumerWidget {
  const OptionalAppUpdateCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: Insets.medium),
      color: AppColors.ripeMango,
      child: InkWell(
        onTap: launchAppPlayStore,
        child: Padding(
          padding: const EdgeInsets.all(Insets.small * 1.5),
          child: Row(
            children: [
              Icon(
                Icons.build_circle_outlined,
                color: AppColors.eerieBlack,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: Insets.small),
                  child: Text(
                    AppConstants.optionalAppUpdate,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.eerieBlack,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.eerieBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
