import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DetailChatBuyersScreen extends StatefulWidget {
  const DetailChatBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/detail_chat_buyers_screen';

  @override
  State<DetailChatBuyersScreen> createState() => _DetailChatBuyersScreenState();
}

class _DetailChatBuyersScreenState extends State<DetailChatBuyersScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: AppBar(
        backgroundColor: Colours.white,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colours.gray,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Row(
          children: [
            // *Avatar
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(64)),
              child: Image(
                image: AssetImage(
                    'lib/assets/images/products/${arguments['image']}'),
                fit: BoxFit.cover,
                height: 44,
                width: 44,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *Name
                Text(
                  arguments['name'],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
                const SizedBox(height: 4),
                // *Status
                const Text(
                  'Online',
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colours.deepGreen,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              child: Row(
                children: [
                  // *TextField
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(64)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // *Emoticon Button
                          IconButton(
                            onPressed: () {},
                            color: Colours.black,
                            icon: const Icon(Icons.emoji_emotions_outlined),
                          ),
                          // *TextFormField
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              focusNode: _messageFocus,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLength: null,
                              maxLines: null,
                              style: const TextStyle(
                                color: Colours.black,
                                fontSize: 16,
                                fontWeight: FontStyles.regular,
                                fontFamily: FontStyles.leagueSpartan,
                              ),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(maxWidth: screenSize.width * 0.4),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                                isDense: true,
                                hintText: 'Tulis pesan...',
                              ),
                            ),
                          ),
                          // *Add Button
                          IconButton(
                            onPressed: () {},
                            color: Colours.black,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.deepGreen,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16)
                    ),
                    child: const Icon(Icons.send_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
