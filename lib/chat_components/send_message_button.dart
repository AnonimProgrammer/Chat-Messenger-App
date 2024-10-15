import 'package:flutter/material.dart';

class SendMessageButton extends StatelessWidget {
  final void Function()? onPressed;
  const SendMessageButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_upward,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
