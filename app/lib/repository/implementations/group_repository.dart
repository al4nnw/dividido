import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/group.dart';
import 'package:dividido/repository/contracts/group_repository.ct.dart';

class GroupRepository implements GroupRepositoryCT {
  final firestore = FirebaseFirestore.instance;
  @override
  String? createdGroupId; // Store the created group ID

  @override
  Future<ExternalResponse> createGroup(Group group) async {
    /// Send it to firestore
    try {
      final doc = await firestore.collection('groups').add(group.toMap());
      createdGroupId = doc.id;

      return ExternalResponse.success;
    } catch (e) {
      log("[GroupRepository] [createGroup] - Error creating group: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<ExternalResponse> deleteGroup(String groupId) async {
    try {
      await firestore.collection('groups').doc(groupId).delete();
      return ExternalResponse.success;
    } catch (e) {
      log("[GroupRepository] [deleteGroup] - Error deleting group: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<ExternalResponse> updateGroup(Group group) async {
    try {
      await firestore.collection('groups').doc(group.id).update({
        'name': group.name,
        'description': group.description,
        // Ensure meta fields are not overwritten
      });
      return ExternalResponse.success;
    } catch (e) {
      log("[GroupRepository] [updateGroup] - Error updating group: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<Group?> getGroup(String groupId) async {
    /// Get last 5 members

    try {
      final group = await firestore.collection('groups').doc(groupId).get();
      return Group.fromMap(group.id, group.data() as Map<String, dynamic>);
    } catch (e) {
      log("[GroupRepository] [getGroup] - Error getting group: $e");
      return null;
    }
  }
}
