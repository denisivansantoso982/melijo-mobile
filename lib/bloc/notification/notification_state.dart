part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial({required this.notifications});

  final List<NotificationModel> notifications;

  @override
  List<Object> get props => [notifications];
}
