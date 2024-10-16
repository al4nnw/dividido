import 'package:dividido/ui/widgets/input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class GroupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  const GroupForm({super.key, required this.nameController, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          label: tr('groupPage.groupNameLabel'),
          hint: tr('groupPage.groupNameHint'),
          controller: nameController,
        ),
        const SizedBox(height: 16.0),
        InputField(
          label: tr('groupPage.groupDescriptionLabel'),
          hint: tr('groupPage.groupDescriptionHint'),
          controller: descriptionController,
        ),
      ],
    );
  }
}
