import 'package:flutter/material.dart';
import 'TaskItem.dart';

class SecondView extends StatefulWidget {
  final TaskItem title;

  SecondView(this.title);

  @override
  State<StatefulWidget> createState() {
    return SecondViewState(title);
  }
}

class SecondViewState extends State<SecondView> {
  String message;
  bool status;

  TextEditingController textEditingController;

  SecondViewState(TaskItem task) {
    this.message = task.title;
    this.status = task.completed;

    textEditingController = TextEditingController(text: task.title);
    textEditingController.addListener(() {
      setState(() {
        message = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('TIG169 TODO',
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Add task item',
              labelStyle:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
          onPressed: () {
            if (message.isEmpty) {
              print("taskTitle == null");
            } else {
              Navigator.pop(
                  context, TaskItem(title: message, completed: status));
            }
          },
          child: Text('ADD'),
        ),
      ]),
    );
  }
}
