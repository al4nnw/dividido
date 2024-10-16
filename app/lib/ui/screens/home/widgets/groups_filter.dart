import 'package:flutter/material.dart';

class GroupsFilter extends StatefulWidget {
  const GroupsFilter({super.key});

  @override
  State<GroupsFilter> createState() => _GroupsFilterState();
}

class _GroupsFilterState extends State<GroupsFilter> {
  @override
  Widget build(BuildContext context) {
    final borderColors = Colors.grey[400]!;
    return Container(
      decoration: BoxDecoration(
        // border top and bottom 1px solid grey
        border: Border(
          bottom: BorderSide(width: 1.0, color: borderColors),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: const Text("GroupsFilter"),
    );
  }
}
