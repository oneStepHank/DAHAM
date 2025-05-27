import 'package:daham/Data/task.dart';

class Group {
  final String id;
  final String title;
  final String description;
  final int maxMembers;
  final List<String> members;
  late final double progress;
  final List<Task> tasks; // ✅ 추가

  Group({
    required this.id,
    required this.title,
    required this.description,
    required this.maxMembers,
    required this.members,
    this.progress = 0.0,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];
}
