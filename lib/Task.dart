import 'package:flutter/material.dart';
import 'Api.dart';

class Task {
  String title;
  bool completed;
  String id;

  Task({@required this.title, this.completed = false, this.id});

  static Map<String, dynamic> toJson(Task task) {
    return {
      'title': task.title,
      'done': task.completed,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['done'],
      id: json['id'],
    );
  }
}

class TaskState extends ChangeNotifier {
  Future getList() async {
    List<Task> listForApi = (await Api.getTasks()).cast<Task>();
    _list = listForApi;
    notifyListeners();
  }

  List<Task> _list = [];
  List<Task> filteredList;
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

  List<Task> filterList(List<Task> task, String filter) {
    if (filter == 'all') {
      filteredList = task;
    } else if (filter == 'done') {
      filteredList = task.where((i) => i.completed).toList();
    } else {
      filteredList = task.where((i) => !i.completed).toList();
    }
    return filteredList;
  }
}
