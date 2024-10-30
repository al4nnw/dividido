import 'package:dividido/ui/screens/group/group_page.dart';
import 'package:dividido/ui/screens/group/group_page_providers.dart';
import 'package:dividido/ui/screens/home/widgets/group_list_provider.dart';
import 'package:dividido/ui/screens/routes/group_navigator.dart';
import 'package:dividido/ui/widgets/card_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupsList extends ConsumerStatefulWidget {
  final String idToSearchFor;

  const GroupsList({super.key, required this.idToSearchFor});

  @override
  _GroupsListState createState() => _GroupsListState();
}

class _GroupsListState extends ConsumerState<GroupsList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final groupsListState = ref.read(groupsListProvider(widget.idToSearchFor));

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
          !groupsListState.isLoading &&
          groupsListState.hasMore) {
        ref.read(groupsListProvider(widget.idToSearchFor).notifier).fetchNextBatch();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(groupsListProvider(widget.idToSearchFor).notifier).refresh();
  }

  void _onTapGroup(String groupId) {
    ref.read(currentGroupIdProvider.notifier).state = groupId;

    groupNavigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => const GroupPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final groupsListState = ref.watch(groupsListProvider(widget.idToSearchFor));

    if (groupsListState.isLoading && groupsListState.groups.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: groupsListState.groups.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (groupsListState.errorMessage != null)
                  Center(child: Text('Error: ${groupsListState.errorMessage}'))
                else
                  const Center(child: Text('No groups found')),
              ],
            )
          : ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              itemCount: groupsListState.groups.length + (groupsListState.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < groupsListState.groups.length) {
                  final group = groupsListState.groups[index];

                  final createdAt = group.meta.createdAt;
                  final formattedDate = '${createdAt.day}/${createdAt.month}/${createdAt.year}';

                  return CardTile(
                    key: ValueKey(group.id),
                    title: group.name,
                    subtitle: 'Criado em $formattedDate por ${group.ownerName}',
                    showUnderline: true,
                    addPadding: true,
                    onTap: () {
                      _onTapGroup(group.id);
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
    );
  }
}
