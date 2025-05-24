import 'package:flutter/material.dart';
import '../Data/group.dart';

class GroupProvider extends ChangeNotifier {
  final List<Group> _groups = [];

  List<Group> get groups => _groups;

  void createGroup(Group group) {
    _groups.add(group);
    notifyListeners();
  }

  Group? searchGroupByName(String name) {
    try {
      return _groups.firstWhere((g) => g.title == name);
    } catch (_) {
      return null;
    }
  }

  void joinGroup(String groupId, String userId) {
    final group = _groups.firstWhere((g) => g.id == groupId);
    if (!group.members.contains(userId) &&
        group.members.length < group.maxMembers) {
      group.members.add(userId);
      notifyListeners();
    }
  }
}
