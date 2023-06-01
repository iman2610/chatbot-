import 'package:flutter/material.dart';
import '../../logic/cubit/chat_cubit.dart';
import '../constants/constants.dart';

class Textreponse extends StatelessWidget {
  const Textreponse({
    Key? key,
    required this.reponse,
  }) : super(key: key);
  final String reponse;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          reponse.isNotEmpty ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(
              reponse!.isNotEmpty ? 1 : 0.1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            reponse.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: reponse!.isNotEmpty
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
          )),
    );
  }
}
