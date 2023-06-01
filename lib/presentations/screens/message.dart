import 'package:flutter/material.dart';
import '../../logic/cubit/chat_cubit.dart';
import '../constants/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isNotEmpty ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(
            message!.isNotEmpty ? 1 : 0.1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message.toString(),
          // locale: const Locale('fr', 'UTF-8'),
          style: TextStyle(
            color: message!.isNotEmpty
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
    );
  }
}
