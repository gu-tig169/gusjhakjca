import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SecondView.dart';
import 'TaskList.dart';
import 'TaskItem.dart';
import 'Constants.dart';

class TaskListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('TIG169 TODO',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: <Widget>[
          PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              onSelected: (choice) {
                var state = Provider.of<TaskState>(context, listen: false);
                state.filterChange(choice);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.grey,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: (choice),
                    child:
                        Text((choice), style: TextStyle(color: Colors.white)),
                  );
                }).toList();
              })
        ],
      ),
      body: Consumer<TaskState>(
        builder: (context, state, child) => TaskList(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () async {
          var newTask = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SecondView(TaskItem(title: null, completed: false))),
          );
          if (newTask != null) {
            Provider.of<TaskState>(context, listen: false).addTask(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void choiceAction(String choice) {
  if (choice == Constants.all) {
    Filter.show = "all";
  } else if (choice == Constants.done) {
    Filter.show = "done";
  } else if (choice == Constants.undone) {
    Filter.show = "undone";
  }
}
