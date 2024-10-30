import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/group.dart';
import 'package:dividido/models/meta.dart';
import 'package:dividido/repository/contracts/group_repository.ct.dart';
import 'package:dividido/repository/implementations/group_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupPageController {
  final GroupRepositoryCT _repository = GroupRepository();
  String? groupId; // Store the created group's ID

  Future<void> createGroup({
    required String name,
    required String description,
    required String creatorId,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is null');
    }

    final group = Group(
      id: '', // Firestore will assign an ID
      name: name,
      ownerId: user.uid,
      ownerName: user.displayName ?? '',
      description: description,
      meta: Meta.now(creatorId),
      memberIds: [user.uid],
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
    required Group group,
  }) async {
    if (groupId == null) {
      throw Exception('Group ID is null');
    }

    final updatedGroup = {
      ...group.toMap(),
      'name': name,
      'description': description,
    };

    final result = await _repository.updateGroup(Group.fromMap(groupId!, updatedGroup));

    if (result == ExternalResponse.error) {
      throw Exception('Error updating group');
    }
  }

  Future<Group?> getGroup(String groupId) async {
    return _repository.getGroup(groupId);
  }
}
