import 'package:flutter/material.dart';
import 'Api.dart';

class TaskItem {
  String title;
  bool completed;
  String id;

  TaskItem({@required this.title, this.completed = false, this.id});

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
      id: json['id'],
    );
  }
}

class TaskState extends ChangeNotifier {
  Future getList() async {
    List<TaskItem> listForApi = await Api.getTasksApi();
    _list = listForApi;
    notifyListeners();
  }

//Ursprungliga listan
  List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

  void addTaskItem(TaskItem task) async {
    await Api.addTaskApi(task);
    await getList();
  }

  void removeTask(TaskItem task) async {
    await Api.deleteTask(task.title);
    await getList();
  }

  bool getDone(index) => list[index].completed;

  void changeValue(TaskItem task, bool newValue) async {
    task.completed = newValue;
    await Api.updateTask(
      task,
      task.id,
    );
    notifyListeners();
  }

  List<TaskItem> filterList(List<TaskItem> task, String filter) {
    List<TaskItem> _filteredList;
    if (filter == 'all') {
      _filteredList = task;
    } else if (filter == 'done') {
      _filteredList = task.where((i) => i.completed).toList();
    } else {
      _filteredList = task.where((i) => !i.completed).toList();
    }
    return _filteredList;
  }
}
