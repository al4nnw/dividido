import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpensesPage extends StatelessWidget {
  final String groupId;

  const ExpensesPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the expenses list UI
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('expensesPage.title')),
      ),
      body: Center(
        child: Text(tr('expensesPage.content')),
      ),
    );
  }
}
