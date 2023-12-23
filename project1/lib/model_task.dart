class Task {
  // static final List<Task> todos = [], done = [];
  static final List<Task> todos = [
    Task(title: 'Test 1'),
    Task(title: 'Test 2', deadline: DateTime.now()),
  ], done = [Task(title: 'Test 3')];

  DateTime? deadline;
  String title;
  String? details;
  bool priority = false;

  Task({
  required this.title,
  this.deadline,
  this.details,
  });
}
