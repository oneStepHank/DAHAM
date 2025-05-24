class Group {
  final String id;
  final String title;
  final String description;
  final int maxMembers;
  final List<String> members;
  final double progress;

  Group({
    required this.id,
    required this.title,
    required this.description,
    required this.maxMembers,
    required this.members,
    this.progress = 0.0,
  });
}
