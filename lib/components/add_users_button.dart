import 'package:flutter/material.dart';

class AddUsersButton extends StatelessWidget {
  final void Function()? onTap;
  const AddUsersButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.only(
          right: 7,
          left: 7,
          top: 7,
          bottom: 10,
        ),
        child: Center(
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
