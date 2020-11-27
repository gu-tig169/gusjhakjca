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
    List<Task> listForApi = await Api.getTasksApi();
    _list = listForApi;
    notifyListeners();
  }

  List<Task> _list = [];
  List<Task> filteredList;
  List<Task> get list => _list;

  void addTask(Task task) async {
    await Api.addTaskApi(task);
    await getList();
  }

  void removeTask(Task task) async {
    await Api.deleteTaskApi(task.id);
    await getList();
  }

  void changeToggle(Task task, bool newValue) async {
    task.completed = newValue;
    await Api.updateTask(task, task.id);
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
