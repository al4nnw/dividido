import 'package:dividido/ui/screens/group/group_page_providers.dart';
import 'package:dividido/ui/screens/group/widgets/group_form.dart';
import 'package:dividido/ui/screens/group/widgets/group_header.dart';
import 'package:dividido/ui/widgets/header.dart';
import 'package:dividido/ui/widgets/input_field.dart';
import 'package:dividido/ui/widgets/rounded_fab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/group_fab.dart';

class GroupPage extends ConsumerStatefulWidget {
  const GroupPage({super.key});

  @override
  ConsumerState<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends ConsumerState<GroupPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldShowForm = ref.watch(shouldShowFormProvider);
    return Scaffold(
      floatingActionButton: GroupFab(
        onCreateGroup: _onCreateGroup,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GroupHeader(),
            if (shouldShowForm)
              GroupForm(
                nameController: nameController,
                descriptionController: descriptionController,
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (nameController.text.trim().isEmpty) {
      _showMessage(tr('groupPage.emptyName'));
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showMessage(tr('groupPage.emptyDescription'));
      return false;
    }
    return true;
  }

  Future<void> _onCreateGroup() async {
    if (!_validateInputs()) return;
    final groupController = ref.read(groupPageControllerProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await groupController.createGroup(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        creatorId: userId, // Replace with actual user ID
      );
      ref.read(justCreatedGroupProvider.notifier).state = true;

      // Set groupId if not null
      final groupId = groupController.groupId;

      if (groupId != null) {
        ref.read(currentGroupIdProvider.notifier).state = groupId;
      }
      ref.read(creatingGroupProvider.notifier).state = false;
      _showMessage(tr('groupPage.createSuccess'));
    } catch (e) {
      _showMessage(tr('groupPage.createError'));
    } finally {
      ref.read(creatingGroupProvider.notifier).state = false;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
