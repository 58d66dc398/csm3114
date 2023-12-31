class Task {
  static final List<Task> todos = [], done = [], star = [];

  static bool toggleStar(Task task) {
    if (star.contains(task)) {
      star.remove(task);
      return false;
    } else {
      star.add(task);
      return true;
    }
  }

  static int _sortFunction(Task a, Task b) {
    if (a.deadline != null) {
      if (b.deadline != null) {
        return a.deadline!.compareTo(b.deadline!);
      } else {
        return -1;
      }
    } else {
      if (b.deadline != null) {
        return 1;
      } else {
        return a.title.compareTo(b.title);
      }
    }
  }

  static sortAll() {
    todos.sort(_sortFunction);
    done.sort((a, b) => a.title.compareTo(b.title));
    star.sort(_sortFunction);
    // print("DEBUG:TODOS: ${todos.join(", ")}");
    // print("DEBUG:DONE: ${done.join(", ")}");
    // print("DEBUG:STAR: ${star.join(", ")}");
  }

  DateTime? deadline;
  String title;
  String details;

  Task({
    required this.title,
    this.deadline,
    this.details = "",
  });

  @override
  String toString() {
    return title;
  }
}
