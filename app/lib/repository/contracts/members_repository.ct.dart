import 'package:dividido/const/external_response.dart';
import 'package:dividido/models/member.dart';

abstract class MembersRepositoryCT {
  final String groupId;

  MembersRepositoryCT(this.groupId);

  Future<ExternalResponse> addMember(Member member);

  Future<ExternalResponse> removeMember(String memberId);

  Future<List<Member>?> getMembers();

  Future<List<Member>?> getLast5Members();
}
