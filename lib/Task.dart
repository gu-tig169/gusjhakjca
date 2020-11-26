import 'package:flutter/material.dart';

class Task {
  String title;
  bool completed;

  Task({@required this.title, this.completed = false});
}

class TaskState extends ChangeNotifier {
  List<Task> _list = [];

  List<Task> get list => _list;

  void addTask(Task task) {
    _list.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _list.remove(task);
    notifyListeners();
  }

  void changeToggle(Task task, bool newValue) {
    task.completed = newValue;

    notifyListeners();
  }

  List<Task> filterList(List<Task> tasks, String filter) {
    List<Task> filteredList;
    if (filter == 'all') {
      filteredList = tasks;
    } else if (filter == 'done') {
      filteredList = tasks.where((i) => i.completed).toList();
    } else {
      filteredList = tasks.where((i) => !i.completed).toList();
    }
    return filteredList;
  }
}
