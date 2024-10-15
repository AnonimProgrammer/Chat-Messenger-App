import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String messageText;
  final bool isCurrentUser;
  const MessageTile({
    super.key,
    required this.messageText,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    Color messageColor = (isCurrentUser)
        ? Colors.green
        : Theme.of(context).colorScheme.secondary;

    Color textColor = (isCurrentUser)
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.inversePrimary;
    return Container(
      decoration: BoxDecoration(
        color: messageColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        messageText,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
