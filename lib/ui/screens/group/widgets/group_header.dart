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

    if (ref.watch(creatingGroupProvider)) {
      headerTitle = tr("groupPage.title");
    } else {
      headerTitle = "Group name";
    }

    return Header(
      title: headerTitle,
      showBackButton: true,
    );
  }
}
