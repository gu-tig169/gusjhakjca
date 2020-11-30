import 'package:flutter/material.dart';
import 'Api.dart';
import 'Constants.dart';

class TaskItem {
  String title;
  bool completed = false;
  String taskId;

  TaskItem({this.title, this.completed, this.taskId});

  static Map<String, dynamic> toJson(TaskItem task) {
    return {
      'title': task.title,
      'done': task.completed,
    };
  }

  static TaskItem fromJson(Map<String, dynamic> json) {
    return TaskItem(
      title: json['title'],
      completed: json['done'],
      taskId: json['id'],
    );
  }
}

class TaskState extends ChangeNotifier {
  //Ursprungliga listan
  List<TaskItem> _list = [];
  List<TaskItem> get list => _list;

  Future getList() async {
    List<TaskItem> list = await Api.getTasks();
    _list = list;
    notifyListeners();
  }

  void addTask(TaskItem task) async {
    if (task.title == null) {
      await getList();
    } else {
      await Api.addTask(task);
      await getList();
    }
  }

  void removeTask(TaskItem task) async {
    await Api.deleteTask(task.taskId);
    await getList();
  }

  void filterChange(String choice) async {
    Filter.show = choice;
    await Api.getTasks();
    await getList();
    filteredList(choice);
    notifyListeners();
  }

  void changeValue(TaskItem task, bool newValue) async {
    task.completed = newValue;
    await Api.updateTask(task);
    await getList();
  }

  void filteredList(String choice) {
    if (choice == 'all') {
      _list = list.toList();
    } else if (choice == 'done') {
      _list = list.where((task) => task.completed == true).toList();
    } else {
      _list = list.where((task) => task.completed == false).toList();
    }
  }
}
