import 'package:dividido/ui/screens/group/group_page.dart';
import 'package:dividido/ui/screens/group/group_page_providers.dart';
import 'package:dividido/ui/screens/home/widgets/groups_list.dart';
import 'package:dividido/ui/screens/routes/group_navigator.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/groups_filter.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(creatingGroupProvider.notifier).state = true;

          groupNavigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const GroupPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(title: 'Dividido'),
          const GroupsFilter(),
          Expanded(
            child: GroupsList(
              idToSearchFor: userId,
            ),
          ),
        ],
      ),
    );
  }
}
