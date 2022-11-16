part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FillNotification extends NotificationEvent {
  const FillNotification({required this.notifications});

  final List<NotificationModel> notifications;

  @override
  List<Object> get props => [notifications];
}

class RemoveNotification extends NotificationEvent {
  const RemoveNotification();

  @override
  List<Object> get props => [];
}