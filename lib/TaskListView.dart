import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SecondView.dart';
import 'TaskList.dart';
import 'Task.dart';

class TaskListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListViewState();
  }
}

class TaskListViewState extends State<TaskListView> {
  String filter = 'All';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('TIG169 TODO'),
        actions: <Widget>[
          DropdownButton(
            value: filter,
            items: [
              DropdownMenuItem(value: 'All', child: Text('All')),
              DropdownMenuItem(value: 'Done', child: Text('Done')),
              DropdownMenuItem(value: 'Undone', child: Text('Undone')),
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
            Provider.of<TaskState>(context, listen: false).addTask(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
