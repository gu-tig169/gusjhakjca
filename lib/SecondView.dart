import 'package:flutter/material.dart';
import 'Task.dart';

class SecondView extends StatefulWidget {
  final String title;

  SecondView(this.title);

  @override
  State<StatefulWidget> createState() {
    return SecondViewState();
  }
}

class SecondViewState extends State<SecondView> {
  String taskTitle;

  TextEditingController textEditingController = new TextEditingController();

  SecondViewState() {
    textEditingController.addListener(() {
      setState(() {
        taskTitle = textEditingController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.title),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'TODO',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (taskTitle != null) {
              Navigator.pop(
                  context,
                  Task(
                    title: taskTitle,
                  ));
            } else {
              print("taskTitle == null");
            }
          },
          child: Text('ADD'),
        ),
      ]),
    );
  }
}
