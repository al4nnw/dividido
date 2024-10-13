import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/member.dart';
import 'package:dividido/repository/contracts/members_repository.ct.dart';

class MembersRepository implements MembersRepositoryCT {
  @override
  final String groupId;
  final firestore = FirebaseFirestore.instance;
  late final CollectionReference membersCollection;

  MembersRepository(this.groupId) {
    membersCollection = FirebaseFirestore.instance.collection('groups').doc(groupId).collection('members');
  }

  @override
  Future<ExternalResponse> addMember(Member member) async {
    try {
      await membersCollection.add(member.toMap());
      return ExternalResponse.success;
    } catch (e) {
      log("[MembersRepository] [addMember] - Error adding member: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<ExternalResponse> removeMember(String memberId) async {
    try {
      await membersCollection.doc(memberId).delete();
      return ExternalResponse.success;
    } catch (e) {
      log("[MembersRepository] [deleteMember] - Error deleting member: $e");
      return ExternalResponse.error;
    }
  }

  @override
  Future<List<Member>?> getMembers() async {
    try {
      final members = await membersCollection.get();
      return members.docs.map((e) => Member.fromMap(e.data() as Map<String, dynamic>, e.id)).toList();
    } catch (e) {
      log("[MembersRepository] [getMembers] - Error getting members: $e");
      return null;
    }
  }

  @override
  Future<List<Member>?> getLast5Members() async {
    try {
      final members = await membersCollection.limit(5).get();
      return members.docs.map((e) => Member.fromMap(e.data() as Map<String, dynamic>, e.id)).toList();
    } catch (e) {
      log("[MembersRepository] [getLast5Members] - Error getting last 5 members: $e");
      return null;
    }
  }
}
