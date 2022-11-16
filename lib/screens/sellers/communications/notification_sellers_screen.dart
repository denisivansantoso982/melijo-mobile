import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:melijo/bloc/notification/notification_bloc.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/notification_model.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class NotificationSellersScreen extends StatelessWidget {
  const NotificationSellersScreen({Key? key}) : super(key: key);

  static const String route = '/notification_sellers_screen';

  Future<void> readNotificationProcess(BuildContext context, NotificationModel notif) async {
    try {
      await readNotifications(notif);
    } catch (error) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colours.white,
          ),
          child: ModalBottom(
            title: 'Terjadi Kesalahan!',
            message: '$error',
            widgets: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen, width: 1),
                  fixedSize: const Size.fromWidth(80),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 18,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            if (state.notifications.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak Ada Notifikasi!',
                  style: TextStyle(
                    color: Colours.gray,
                    fontSize: 20,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => readNotificationProcess(context, state.notifications[index]),
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  shape: const Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colours.lightGray,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 88,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // *Notification Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // *Title
                              Text(
                                state.notifications[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colours.black,
                                  fontSize: 16,
                                  fontWeight: FontStyles.bold,
                                  fontFamily: FontStyles.lora,
                                ),
                              ),
                              // *Subtitle
                              Text(
                                state.notifications[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colours.gray,
                                  fontSize: 16,
                                  fontWeight: FontStyles.regular,
                                  fontFamily: FontStyles.leagueSpartan,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // *Time and Read Marks
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: state.notifications[index].isread
                                    ? Colors.transparent
                                    : Colours.deepGreen,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              DateFormat('dd MM yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      state.notifications[index].send_at)),
                              style: TextStyle(
                                color: state.notifications[index].isread
                                    ? Colours.gray
                                    : Colours.deepGreen,
                                fontSize: 14,
                                fontFamily: FontStyles.leagueSpartan,
                                fontWeight: FontStyles.medium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Terjadi Kesalahan!',
                style: TextStyle(
                    color: Colours.gray,
                    fontSize: 20,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan),
              ),
            );
          }
        },
      ),
    );
  }
}
