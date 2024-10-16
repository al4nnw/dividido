import 'package:dividido/ui/screens/group/group_page_providers.dart';
import 'package:dividido/ui/widgets/rounded_fab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupFab extends ConsumerStatefulWidget {
  final void Function() onCreateGroup;

  const GroupFab({super.key, required this.onCreateGroup});

  @override
  ConsumerState<GroupFab> createState() => _GroupFabState();
}

class _GroupFabState extends ConsumerState<GroupFab> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final creatingGroup = ref.watch(creatingGroupProvider);
    final updatingGroup = ref.watch(updatingGroupProvider);

    if (creatingGroup || updatingGroup) {
      final messageKey = creatingGroup ? 'create' : 'updating';
      return RoundedFab(
        onPressed: widget.onCreateGroup,
        icon: Icons.add,
        content: tr('groupPage.$messageKey'),
      );
    }

    return RoundedFab(
      onPressed: widget.onCreateGroup,
      icon: Icons.add,
      content: tr('groupPage.addExpense'),
    );
  }
}
