import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/communications/detail_chat_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class ChatBuyersScreen extends StatelessWidget {
  const ChatBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/chat_buyers_screen';

  static final List<Map<String, dynamic>> _listOfChat = [
    {
      'image': 'bawang_daun.jpg',
      'name': 'Admin 1',
      'message': 'Jangan lupa order lagi',
      'read': true,
    },
    {
      'image': 'bawang_merah.jpg',
      'name': 'Admin 2',
      'message': 'Jangan lupa order lagi',
      'read': false,
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
          'Pesan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _listOfChat.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            DetailChatBuyersScreen.route,
            arguments: _listOfChat[index],
          ),
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: const Border(bottom: BorderSide(width: 1, color: Colours.lightGray,)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // *Chat Image
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(64)),
                    child: Image(
                      image: AssetImage('lib/assets/images/products/${_listOfChat[index]['image']}'),
                      fit: BoxFit.cover,
                      width: 56,
                      height: 56,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // *Chat Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // *Title
                        Text(
                          _listOfChat[index]['name'],
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
                          _listOfChat[index]['message'],
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
                    visible: !_listOfChat[index]['read'],
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
      ),
    );
  }
}
