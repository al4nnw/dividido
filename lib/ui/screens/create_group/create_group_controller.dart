import 'package:dividido/repository/contracts/group_repository.ct.dart';
import 'package:dividido/repository/implementations/group_repository.dart';

class CreateGroupController {
  final GroupRepositoryCT _repository = GroupRepository();

  Future<void> createGroup(String name, String description) async {
    await _repository.createGroup(name, description);
  }
}
