import 'package:dividido/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupsListState {
  final List<Group> groups;
  final bool isLoading;
  final bool hasMore;
  final String? errorMessage;

  GroupsListState({
    required this.groups,
    required this.isLoading,
    required this.hasMore,
    this.errorMessage,
  });

  factory GroupsListState.initial() {
    return GroupsListState(
      groups: [],
      isLoading: false,
      hasMore: true,
      errorMessage: null,
    );
  }

  GroupsListState copyWith({
    List<Group>? groups,
    bool? isLoading,
    bool? hasMore,
    String? errorMessage,
  }) {
    return GroupsListState(
      groups: groups ?? this.groups,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

class GroupsListNotifier extends StateNotifier<GroupsListState> {
  GroupsListNotifier({required this.idToSearchFor}) : super(GroupsListState.initial()) {
    _init();
  }

  final String idToSearchFor;
  static const int _limit = 10;
  DocumentSnapshot? _lastDocument;
  late Query _query;

  void _init() {
    _query = FirebaseFirestore.instance
        .collection('groups')
        .where('memberIds', arrayContains: idToSearchFor)
        .orderBy('meta.createdAt', descending: true)
        .limit(_limit);

    fetchNextBatch();
  }

  Future<void> fetchNextBatch() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      Query query = _query;

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;

        List<Group> fetchedGroups = snapshot.docs.map((doc) {
          return Group.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }).toList();

        final allGroups = List<Group>.from(state.groups)..addAll(fetchedGroups);

        state = state.copyWith(
          groups: allGroups,
          hasMore: snapshot.docs.length >= _limit,
          isLoading: false,
        );
      } else {
        state = state.copyWith(hasMore: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    _lastDocument = null;
    state = state.copyWith(
      groups: [],
      isLoading: false,
      hasMore: true,
      errorMessage: null,
    );
    fetchNextBatch();
  }
}

final groupsListProvider = StateNotifierProvider.autoDispose
    .family<GroupsListNotifier, GroupsListState, String>((ref, idToSearchFor) {
  return GroupsListNotifier(idToSearchFor: idToSearchFor);
});
