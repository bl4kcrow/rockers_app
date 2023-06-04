import 'package:intl/intl.dart';

extension DurationExtensions on Duration {
  String toMinutesSeconds() {
    String twoDigitMinutes = NumberFormat('00').format(
      inMinutes.remainder(60),
    );
    String twoDigitSeconds = NumberFormat('00').format(
      inSeconds.remainder(60),
    );

    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
