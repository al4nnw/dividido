import 'package:dividido/ui/screens/home/widgets/groups_filter.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class PlusReceipt extends StatefulWidget {
  const PlusReceipt({super.key});

  @override
  State<PlusReceipt> createState() => _PlusReceiptState();
}

class _PlusReceiptState extends State<PlusReceipt> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(title: 'Plus Receipt'),
          GroupsFilter(),
        ],
      ),
    );
  }
}
