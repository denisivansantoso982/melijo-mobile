// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/notification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial(notifications: <NotificationModel>[])) {
    on<FillNotification>((event, emit) => _onFillNotification(event, emit));
    on<RemoveNotification>((event, emit) => _onRemoveNotification(event, emit));
  }

  void _onFillNotification(FillNotification event, Emitter<NotificationState> emit) {
    final NotificationState state = NotificationInitial(notifications: event.notifications);

    if (state is NotificationInitial) {
      emit(
        NotificationInitial(notifications: state.notifications),
      );
    }
  }

  void _onRemoveNotification(RemoveNotification event, Emitter<NotificationState> emit) {
    final NotificationState state = this.state;

    if (state is NotificationInitial) {
      emit(
        const NotificationInitial(notifications: [])
      );
    }
  }
}
