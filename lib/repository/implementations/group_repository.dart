import 'package:dividido/const/external_response.dart';
import 'package:dividido/repository/contracts/group_repository.ct.dart';

class GroupRepository implements GroupRepositoryCT {
  @override
  Future<ExternalResponse> addGroupMember(String groupId, String userId) {
    // TODO: implement addGroupMember
    throw UnimplementedError();
  }

  @override
  Future<ExternalResponse> createGroup(String groupName, String userId) {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  @override
  Future<ExternalResponse> deleteGroup(String groupId) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Future<GetGroupResponse> getGroup(String groupId) {
    // TODO: implement getGroup
    throw UnimplementedError();
  }

  @override
  Future<ExternalResponse> removeGroupMember(String groupId, String userId) {
    // TODO: implement removeGroupMember
    throw UnimplementedError();
  }
}
