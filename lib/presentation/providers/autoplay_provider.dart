import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/presentation/presentation.dart';

final autoplayProvider = StateProvider<bool>((ref) {
  return ref.watch(sharedUtilityProvider).isAutoplayEnabled();
});
