import 'package:dividido/ui/screens/create_group/widgets/members_list.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:dividido/ui/widgets/input_field.dart';
import 'package:dividido/ui/widgets/rounded_fab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedFab(
        onPressed: () {},
        icon: Icons.add,
        content: tr("createGroup.create"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(
            title: tr("createGroup.title"),
            leading: const BackButton(),
          ),
          InputField(
            label: tr("createGroup.groupNameLabel"),
            hint: tr("createGroup.groupNameHint"),
            controller: controller,
          ),
          const MembersList(),
        ],
      ),
    );
  }
}
