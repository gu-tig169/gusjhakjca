import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final String filter;

  TaskList(this.tasks, this.filter);

  Widget build(BuildContext context) {
    List<Task> filteredList = Provider.of<TaskState>(context, listen: false)
        .filterList(tasks, filter);
    return ListView(
        children:
            filteredList.map((task) => _taskItem(context, task)).toList());
  }

  Widget _taskItem(context, task) {
    return ListTile(
      leading: Checkbox(
          value: task.completed,
          onChanged: (bool newValue) {
            var state = Provider.of<TaskState>(context, listen: false);
            state.changeToggle(task, newValue);
          }),
      title: StrikeThrough(task),
      trailing: IconButton(
        icon: Icon(Icons.cancel_presentation),
        onPressed: () {
          var state = Provider.of<TaskState>(context, listen: false);
          state.removeTask(task);
        },
      ),
    );
  }
}

class StrikeThrough extends StatelessWidget {
  final Task task;
  StrikeThrough(this.task);

  Widget _strikeThroughWidget() {
    if (task.completed == false) {
      return Text(task.title);
    } else {
      return Text(
        task.title,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _strikeThroughWidget();
  }
}
