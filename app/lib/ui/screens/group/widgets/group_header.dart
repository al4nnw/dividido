import 'dart:developer';

import 'package:dividido/ui/screens/group/group_page_providers.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupHeader extends ConsumerWidget {
  const GroupHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String headerTitle;
    bool creatingGroup = ref.watch(creatingGroupProvider);
    final groupId = ref.watch(currentGroupIdProvider);
    final group = ref.watch(currentGroupProvider);

    if (creatingGroup) {
      headerTitle = tr("groupPage.title");
    } else if (groupId != null) {
      headerTitle = group.when(data: (data) {
        if (data == null) return tr("groupPage.title");

        return data.name;
      }, error: (error, stack) {
        log("[GroupHeader] Error while getting group: $error");
        return tr("groupPage.title");
      }, loading: () {
        return tr("groupPage.title");
      });
    } else {
      headerTitle = tr("groupPage.createTitle");
    }

    return Header(
      title: headerTitle,
      showBackButton: true,
    );
  }
}
