import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class NotificationBuyersScreen extends StatelessWidget {
  const NotificationBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/notification_buyers_screen';

  static final List<Map<String, dynamic>> _listOfNotification = [
    {
      'image': 'bawang_daun.jpg',
      'title': 'Admin 1',
      'subtitle': 'Woy',
      'read': false,
    },
    {
      'image': 'bawang_merah.jpg',
      'title': 'Admin 2',
      'subtitle': 'jadi gak bro?',
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(0.2, 0.8),
              colors: [
                Colours.oliveGreen,
                Colours.deepGreen,
              ],
            ),
          ),
        ),
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
      body: ListView.builder(
        itemCount: _listOfNotification.length,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          shape: const Border(bottom: BorderSide(width: 1, color: Colours.lightGray,)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // *Notification Image
                Image(
                  image: AssetImage('lib/assets/images/products/${_listOfNotification[index]['image']}'),
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                ),
                const SizedBox(width: 8),
                // *Notification Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // *Title
                      Text(
                        _listOfNotification[index]['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colours.black,
                          fontSize: 16,
                          fontWeight: FontStyles.bold,
                          fontFamily: FontStyles.lora,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      // *Subtitle
                      Text(
                        _listOfNotification[index]['subtitle'],
                        maxLines: 1,
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
                const SizedBox(width: 8),
                // *Time and Read Marks
                Visibility(
                  visible: !_listOfNotification[index]['read'],
                  child: Column(
                    children: [
                      const Text(
                        'Kemarin',
                        style: TextStyle(
                          color: Colours.deepGreen,
                          fontSize: 12,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.regular,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colours.deepGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colours.white,
                            fontSize: 12,
                            fontFamily: FontStyles.leagueSpartan,
                            fontWeight: FontStyles.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
