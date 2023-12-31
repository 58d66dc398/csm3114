import 'model_task.dart';

Task task2 = Task(title: 'Test 2', deadline: DateTime.now());

void addDummy() {
  Task.todos.insertAll(Task.todos.length, [Task(title: 'Test 1'), task2]);
  Task.done.insert(Task.done.length, Task(title: 'Test 3'));
  Task.star.insert(Task.star.length, task2);
}
