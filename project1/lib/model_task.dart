class Task {
  final DateTime created;
  DateTime? deadline;
  String title;
  String? details;
  bool done = false, priority = false;

  Task({
    required this.created,
    required this.title,
    this.deadline,
    this.details,
  });
}
