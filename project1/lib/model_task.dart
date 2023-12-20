class Task {
  final DateTime created;
  DateTime? deadline;
  String title;
  bool done = false;

  Task({
    required this.created,
    required this.title,
    this.deadline,
  });
}
