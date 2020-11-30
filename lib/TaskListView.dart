import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SecondView.dart';
import 'TaskList.dart';
import 'TaskItem.dart';

class TaskListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListViewState();
  }
}

class TaskListViewState extends State<TaskListView> {
  String filter = 'all';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('TIG169 TODO',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: [
          DropdownButton(
            value: filter,
            items: [
              DropdownMenuItem(value: 'all', child: Text('All')),
              DropdownMenuItem(value: 'done', child: Text('Done')),
              DropdownMenuItem(value: 'undone', child: Text('Undone')),
            ],
            style: TextStyle(color: Colors.black87),
            dropdownColor: Colors.grey[300],
            icon: Icon(Icons.filter_alt_outlined, color: Colors.black87),
            onChanged: (value) {
              setState(() {
                filter = value;
              });
            },
          )
        ],
      ),
      body: Consumer<TaskState>(
          builder: (context, state, child) => TaskList(state.list, filter)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () async {
          var newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondView('TIG169 TODO')),
          );
          print(newTask.toString());
          if (newTask != null) {
            Provider.of<TaskState>(context, listen: false).addTaskItem(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
