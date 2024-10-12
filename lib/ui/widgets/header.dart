import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  const Header({super.key, this.leading, this.trailing, required this.title});

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32) + EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          if (leading != null) leading! else const SizedBox(width: 24),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
