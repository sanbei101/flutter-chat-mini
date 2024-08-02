import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 20),
          Text(text),
        ],
      ),
    );
  }
}
