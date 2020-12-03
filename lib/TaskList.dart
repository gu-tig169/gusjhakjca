import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'TaskItem.dart';

class TaskList extends StatelessWidget {
  final List<TaskItem> _list;

  TaskList(this._list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: _list.map((task) => taskWidget(context, task)).toList());
  }

  Widget taskWidget(context, task) {
    return Card(
        margin: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: CheckboxListTile(
            activeColor: Colors.grey,
            checkColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(task.title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0,
                    decoration: task.status == false
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                    decorationThickness: 2.18)),
            value: task.status,
            tristate: true,
            onChanged: (bool newValue) {
              var state = Provider.of<TaskState>(context, listen: false);
              state.changeValue(task, newValue);
            },
            secondary: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                var state = Provider.of<TaskState>(context, listen: false);
                state.removeTask(task);
              },
            ),
          ),
        ));
  }
}
