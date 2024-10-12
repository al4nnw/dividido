import 'package:dividido/ui/widgets/card_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MembersList extends StatelessWidget {
  const MembersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr("createGroup.memberSectionLabel"),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const CardTile(
            title: "John Doe",
            subtitle: "Added 2 days ago",
            showUnderline: false,
          ),
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () {}, child: Text(tr("createGroup.addMember")))),
        ],
      ),
    );
  }
}
