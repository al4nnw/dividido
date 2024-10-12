import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/group.dart';

abstract class GetGroupResponse {
  final ExternalResponse externalResponse;
  final Group group;

  GetGroupResponse(this.externalResponse, this.group);
}

abstract class GroupRepositoryCT {
  Future<ExternalResponse> createGroup(String groupName, String userId);

  Future<ExternalResponse> addGroupMember(String groupId, String userId);

  Future<ExternalResponse> removeGroupMember(String groupId, String userId);

  Future<ExternalResponse> deleteGroup(String groupId);

  Future<GetGroupResponse> getGroup(String groupId);
}
