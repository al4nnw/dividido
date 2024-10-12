import 'package:dividido/ui/screens/create_group/create_group.dart';
import 'package:dividido/ui/screens/home/widgets/groups_list.dart';
import 'package:dividido/ui/screens/routes/group_navigator.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'widgets/groups_filter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          groupNavigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const CreateGroup(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(title: 'Dividido'),
          GroupsFilter(),
          Expanded(
            child: GroupsList(),
          ),
        ],
      ),
    );
  }
}
