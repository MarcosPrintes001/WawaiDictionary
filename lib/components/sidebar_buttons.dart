import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final IconData icone;

  const SidebarButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.icone});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(
        icone,
        color: Colors.black,
        size: 30,
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
