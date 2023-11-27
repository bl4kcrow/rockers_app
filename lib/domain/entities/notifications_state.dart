import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsState {
  NotificationsState({
    required this.status,
  });

  final AuthorizationStatus status;

  NotificationsState copyWith({
    AuthorizationStatus? status,
  }) {
    return NotificationsState(
      status: status ?? this.status,
    );
  }
}
