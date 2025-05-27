class Task {
  final String id;
  final String title;
  final String subject;
  final Map<String, double> memberProgress; // {userId: 0.0~1.0}

  Task({
    required this.id,
    required this.title,
    required this.subject,
    required this.memberProgress,
  });
}
