import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class ModalBottom extends StatelessWidget {
  const ModalBottom({
    Key? key,
    required this.title,
    required this.message,
    required this.widgets,
  }) : super(key: key);
  final String title;
  final String message;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colours.black,
                  fontSize: 26,
                  fontWeight: FontStyles.medium,
                  fontFamily: FontStyles.leagueSpartan,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  color: Colours.black,
                  fontSize: 18,
                  fontWeight: FontStyles.regular,
                  fontFamily: FontStyles.leagueSpartan,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: widgets,
        ),
      ],
    );
  }
}
