class Task {
  static final List<Task> todos = [], done = [], star = [];

  static int _rules(Task a, Task b) {
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

  static void addTodo(Task task) {
    todos.add(task);
    todos.sort(_rules);
  }

  static void removeTodo(Task task) {
    todos.remove(task);
    if (star.contains(task)) {
      star.remove(task);
    }
  }

  static void insertTodo(int index, Task task, {int starIndex = -1}) {
    todos.insert(index, task);
    if (starIndex > -1) {
      star.insert(starIndex, task);
    }
  }

  static void sortAll() {
    todos.sort(_rules);
    star.sort(_rules);
    done.sort((a, b) => a.title.compareTo(b.title));
  }

  bool toggleStar() {
    if (star.contains(this)) {
      star.remove(this);
      return false;
    } else {
      star.add(this);
      return true;
    }
  }

  DateTime? deadline;
  String title;
  String details;

  Task({
    required this.title,
    this.deadline,
    this.details = "",
  });
}
