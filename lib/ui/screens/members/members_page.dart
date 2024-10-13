import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MembersPage extends StatelessWidget {
  final String groupId;

  const MembersPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('membersPage.title')),
      ),
      body: Center(
        child: Text(tr('membersPage.content')),
      ),
    );
  }
}
