import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskListView.dart';
import 'Task.dart';

void main() {
  var state = TaskState();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIG169 TODO',
      home: TaskListView(),
    );
  }
}
