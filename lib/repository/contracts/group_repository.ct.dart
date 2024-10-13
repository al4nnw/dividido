import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/group.dart';

abstract class GroupRepositoryCT {
  String? createdGroupId;

  Future<ExternalResponse> createGroup(Group group);

  Future<ExternalResponse> deleteGroup(String groupId);

  Future<ExternalResponse> updateGroup(Group group);

  Future<Group?> getGroup(String groupId);
}
