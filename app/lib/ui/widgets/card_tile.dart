import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showUnderline;
  final bool addPadding;
  final Function()? onTap;
  const CardTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showUnderline = false,
    this.addPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: showUnderline
              ? Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey[400]!),
                )
              : null,
        ),
        child: Padding(
          padding: addPadding ? const EdgeInsets.all(16.0) : EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.headlineSmall),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
