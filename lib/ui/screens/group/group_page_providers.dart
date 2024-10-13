import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'group_page_controller.dart';

final showMembersProvider = StateProvider((ref) => false);
final creatingGroupProvider = StateProvider((ref) => false);
final updatingGroupProvider = StateProvider((ref) => false);
final justCreatedGroupProvider = StateProvider((ref) => false);
final groupPageControllerProvider = Provider<GroupPageController>((ref) {
  return GroupPageController();
});

final shouldShowFormProvider = Provider<bool>((ref) {
  final creatingGroup = ref.watch(creatingGroupProvider);
  final updatingGroup = ref.watch(updatingGroupProvider);

  return creatingGroup || updatingGroup;
});
