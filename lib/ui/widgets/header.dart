import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final bool showBackButton;
  final bool addBorderBottom;
  final String title;
  const Header({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.showBackButton = false,
    this.addBorderBottom = true,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Widget? leading;

  @override
  void initState() {
    super.initState();
    leading = widget.leading;

    if (widget.leading == null && widget.showBackButton) {
      leading = const BackButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        // Add a border bottom 1px solid grey
        border: widget.addBorderBottom
            ? Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[400]!),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32) + EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          if (leading != null) leading! else const SizedBox(width: 24),
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}
