import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/group.dart';
import 'package:dividido/models/meta.dart';
import 'package:dividido/repository/contracts/group_repository.ct.dart';
import 'package:dividido/repository/implementations/group_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupPageController {
  final GroupRepositoryCT _repository = GroupRepository();
  String? groupId; // Store the created group's ID

  Future<void> createGroup({
    required String name,
    required String description,
    required String creatorId,
  }) async {
    final group = Group(
      id: '', // Firestore will assign an ID
      name: name,
      description: description,
      meta: Meta.now(creatorId),
    );

    final result = await _repository.createGroup(group);

    if (result == ExternalResponse.error) {
      throw Exception('Error creating group');
    }

    groupId = _repository.createdGroupId; // Retrieve the group ID from the repository
  }

  Future<void> updateGroup({
    required String name,
    required String description,
  }) async {
    if (groupId == null) {
      throw Exception('Group ID is null');
    }

    final group = Group(
      id: groupId!,
      name: name,
      description: description,
      meta: Meta.now(''), // Meta fields should remain unchanged
    );

    final result = await _repository.updateGroup(group);

    if (result == ExternalResponse.error) {
      throw Exception('Error updating group');
    }
  }
}
