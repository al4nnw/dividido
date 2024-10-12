import 'package:flutter/material.dart';

class RoundedFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String content;
  const RoundedFab({super.key, required this.icon, required this.onPressed, required this.content});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(content),
      icon: Icon(icon),
    );
  }
}
