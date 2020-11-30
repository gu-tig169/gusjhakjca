import 'package:flutter/material.dart';
import 'TaskItem.dart';
import 'package:provider/provider.dart';

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
            if (taskTitle != null) {
              Navigator.pop(
                  context,
                  TaskItem(
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
