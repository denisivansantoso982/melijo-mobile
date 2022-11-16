import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/notification/notification_bloc.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.onPress}) : super(key: key);

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    getNotifications(context);
    return IconButton(
      onPressed: onPress,
      color: Colours.white,
      iconSize: 28,
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 8),
      icon: Stack(
        children: [
          const Icon(
            Icons.notifications_outlined,
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
            if (state is NotificationInitial) {
              int unread = state.notifications.where((element) => !element.isread).length;
              return Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: state.notifications.any((element) => !element.isread),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colours.red,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Text(
                      '$unread',
                      style: const TextStyle(
                        color: Colours.white,
                        fontSize: 12,
                        fontFamily: FontStyles.leagueSpartan,
                        fontWeight: FontStyles.medium,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
